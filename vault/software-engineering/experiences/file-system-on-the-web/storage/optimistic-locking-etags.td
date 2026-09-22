---
_type: ExperienceResource
_label: "Optimistic Locking with ETags in REST APIs"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://sookocheff.com/post/api/optimistic-locking-in-a-rest-api/"
kind: 'article'
tags:
  - 'api'
  - 'collaboration'
---

This covers how to prevent lost updates in REST APIs using ETags and conditional requests.

This is the HTTP-native version of the CAS (compare-and-swap) pattern we saw in the GitHub Contents API (where `sha` serves the same purpose).

::: tip
**The pattern**:
1. GET returns an ETag.
2. PUT/DELETE sends it back via `If-Match`.
3. Server rejects with 412 if the resource changed.
4. Client retries after re-fetching.
:::

## The Problem: Lost Updates

Without coordination, concurrent updates cause silent data loss:

1. Client A fetches resource (version 1).
2. Client B fetches same resource (version 1).
3. Client A PUTs its changes. Server accepts (now version 2).
4. Client B PUTs its changes with stale data. Server accepts (now version 3).
5. Client A's changes are silently overwritten. Neither client knows.

## ETags

An ETag (`ETag` HTTP header) is an opaque token the server associates with a particular state of a resource. It changes whenever the resource state changes.

- The server generates and returns it on GET (or HEAD) responses. GET is the typical starting point since the client needs the content to modify it. HEAD can be used for lightweight "has this changed?" checks without downloading the body.
- Clients store it and send it back on subsequent writes.
- The server compares ETags to detect stale updates.

::: note
Same concept as GitHub Contents API's `sha` or the CAS value in compare-and-swap. The specific token format doesn't matter (hash, version number, timestamp), only that it changes on every mutation.
:::

### Who Generates ETags?

- **Static files** (JS, CSS, images): The HTTP server (Nginx, Apache) or CDN generates ETags automatically, typically from file modification time + size. No application code needed.
- **Dynamic resources** (API responses, DB-backed files): The application server must generate and validate ETags itself. The HTTP server has no way to know when a DB row changed.

Our use case is the latter. Files are stored in a DB, served via API. We would generate ETags from the file's hash or version column.

## Conditional Request Headers

- `If-Match: "<etag>"`: Succeeds only if the server's current ETag matches. Used for safe updates (PUT/PATCH/DELETE).
- `If-None-Match: "<etag>"`: Succeeds only if the server's current ETag is different. Used for cache validation (GET returns 304 Not Modified if ETag still matches).

## The Flow with Optimistic Locking

```
Client                              Server
  |                                    |
  |  GET /resource                     |
  |  <-- 200 OK, ETag: "abc123"       |
  |                                    |
  |  (client modifies locally)         |
  |                                    |
  |  PUT /resource                     |
  |  If-Match: "abc123"               |
  |                                    |
  |  (server checks: current ETag      |
  |   == "abc123"?)                    |
  |                                    |
  |  If yes: <-- 200 OK, ETag: "def456"|
  |  If no:  <-- 412 Precondition Failed|
  |                                    |
```

On 412, the client must re-fetch (GET), merge or discard its changes, and retry.

## HTTP Status Codes

- **200 OK**: Update succeeded. Response includes the new ETag.
- **304 Not Modified**: Resource has not changed since the client's cached version (for `If-None-Match` on GET).
- **412 Precondition Failed**: The resource changed since the client last fetched it. Update rejected.

## Why "Optimistic"

No lock is held between GET and PUT. The client assumes no one else will modify the resource, and only discovers conflicts at write time. This is the same CAS semantics seen in:

- GitHub Contents API: `sha` field on PUT/DELETE.
- OneDrive: ETag-based concurrency on DriveItems.
- Any database with optimistic concurrency control (version column).

The alternative is pessimistic locking:

- Client acquires a lock before reading.
- Holds it during edits.
- Releases after writing.
- Prevents conflicts but reduces concurrency and risks deadlocks.

## Takeaways for Our System

- **ETags are the right default for our file APIs**. We need concurrency control for concurrent edits, and optimistic locking avoids the complexity of lock management.
- **412 is the standard conflict response**. Clients must handle it by re-fetching and retrying (or prompting the user to merge).
- **Works naturally with our file model**: Each file has a version/hash. GET returns it, PUT requires it. Simple to implement on top of either database or blob storage.
- **Pairs well with long polling**: When a client gets a 412, it knows the file changed. A long-polling subscription would have already notified it of the change, so 412 should be rare in practice.

---
_type: SoftEngConcept
_label: 'Optimistic Concurrency Control'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'collaboration'
---

A concurrency strategy where no lock is held between read and write. The client reads a value, modifies it locally, and writes it back with a version check. If the version changed, the write is rejected.

## The Pattern

1. Client reads the resource (gets a version token: ETag, SHA, version number).
2. Client modifies locally.
3. Client writes back, including the version token.
4. Server compares tokens. If they match, the write succeeds. If not, the write is rejected (409 Conflict / 412 Precondition Failed).

## Analogies

- Compare-and-Swap (CAS) at the application level.
- ETags + If-Match in HTTP.
- GitHub Contents API: `sha` field on PUT/DELETE.
- Database version columns.

## Contrast with Pessimistic Locking

- Pessimistic: Acquire lock before reading, hold during edits, release after writing. Prevents conflicts but reduces concurrency and risks deadlocks.
- Optimistic: No lock. Conflicts detected at write time. Higher concurrency but clients must handle rejections.

---
_type: ExperienceResource
_label: "GitHub Contents API"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://docs.github.com/en/rest/repos/contents"
kind: 'article'
tags:
  - 'api'
---

GitHub's REST API for file CRUD on a repository, git-backed.

This is closest to our use case for building filesystem APIs over HTTP without cloning repos or running Git locally.

> Out-of-scope: However, this is not suitable for our realtime collaboration use cases (yet).

All endpoints live under `/repos/{owner}/{repo}/contents/{path}`.

## Prerequisites

Auth is passed via the `Authorization` header:

```
Authorization: Bearer <token>
```

## Get repository content

```
GET /repos/{owner}/{repo}/contents/{path}
```

[Formal signature](https://docs.github.com/en/rest/repos/contents?apiVersion=2026-03-10#get-repository-content--parameters)

**Returns**:

- The contents of a file or directory.
  - For files: returns metadata + Base64-encoded content.
  - For directories: returns an array of entry objects.
  - For symlinks: returns the target file content if the target is a normal file.
  - For submodules: `submodule_git_url` identifies the submodule repo location, `sha` identifies the pinned commit within it. Git uses the URL to clone and checks out at that commit.
    - If the submodule repo is not hosted on github.com, `git_url`, `_links["git"]`, `html_url`, and `_links["html"]` will be null.
- Omitting `path` returns root directory contents.

**Parameters** (**Query string**):

- `ref` (optional): Branch, tag, or commit SHA. Defaults to the repo's default branch.

**Custom headers**:
  - Custom media types via `Accept` header:
    - `application/vnd.github.raw+json`: Raw file content.
    - `application/vnd.github.html+json`: HTML-rendered markup.
    - `application/vnd.github.object+json`: Consistent object format regardless of content type.

**Constraints**:
  - Size limits:
    - <= 1 MB: Full content inline.
    - 1-100 MB: Only works with `raw` or `object` media types (`content` field is empty with `object`).
    - \> 100 MB: Not supported, use Git LFS.
  - Directory limit is 1,000 files.
    - For larger directories, use the Git Trees API.
    - To get contents recursively, use the Git Trees API as well.
  - `download_url`: Every response includes a `download_url` field (string or null). It is a temporary direct-download link to the raw file content.
    - Why use this over curling the API directly? The URL is pre-signed (no auth token needed) and returns raw bytes (no Base64 decoding). Useful for passing to tools or services that can't attach your GitHub token.
    - Expires and is meant to be used once. Call the Contents API again for a fresh URL each time.
    - Null for directories and submodules not hosted on github.com.

**Auth**:
  - Works with fine-grained tokens: GitHub App user access tokens, GitHub App installation access tokens, fine-grained personal access tokens.
  - Required permission: "Contents" repository permissions (read).
  - No auth needed for public repos.

## Create or update file contents

```
PUT /repos/{owner}/{repo}/contents/{path}
```

[Formal signature](https://docs.github.com/en/rest/repos/contents?apiVersion=2026-03-10#create-or-update-file-contents--parameters)

Creates a new file or replaces an existing one. Each call produces exactly one commit.

**Parameters** (**Request body**):

- `message` (required): Commit message.
- `content` (required): Base64-encoded file content.
- `sha` (required for updates): Blob SHA of the file being replaced.
  - Acts as concurrency control.
  - If the file changed since you last read it, the request fails with 409 Conflict.
  > Essentially a retry CAS pattern at the application level. 409 = CAS failed.
- `branch` (optional): Defaults to the repo's default branch.
- `committer` (optional): `{ name, email, date }`. Defaults to the authenticated user.
  - Omitting `name` or `email` triggers a 422 error.
- `author` (optional): `{ name, email, date }`. Defaults to committer.
  - Omitting `name` or `email` triggers a 422 error.

**Response**:
  - 201 Created for new files, 200 OK for updates.
  - Returns the file metadata (`content`) and commit details (`commit`).
  - 409 Conflict if `sha` is stale.
  - 422 Validation failed if required body fields are missing.

**Constraints**:
  - PUT/DELETE requests must be sequential. Parallel requests will read the same SHA, but the first to complete changes it, causing the second to fail with 409 (stale SHA). This is a consequence of the CAS-based concurrency control above.
  - The `workflow` scope is required to modify files in `.github/workflows`.

**Auth**:
  - Fine-grained tokens: "Contents" repository permissions (write).
  - Classic tokens: `repo` scope.

## Delete a file

```
DELETE /repos/{owner}/{repo}/contents/{path}
```

[Formal signature](https://docs.github.com/en/rest/repos/contents?apiVersion=2026-03-10#delete-a-file--parameters)

Removes a file from a repository. Each call produces exactly one commit.

**Parameters** (**Request body**):

- `message` (required): Commit message.
- `sha` (required): Blob SHA of the file to delete.
  - Same CAS semantics as Create or update: stale SHA = 409 Conflict.
- `branch` (optional): Defaults to the repo's default branch.
- `committer` (optional): `{ name, email }`. Defaults to the authenticated user.
  - Omitting `name` or `email` triggers a 422 error.
- `author` (optional): `{ name, email }`. Defaults to committer.
  - Omitting `name` or `email` triggers a 422 error.

**Response**:
  - 200 OK on success.
  - Returns the commit details (`commit`). `content` is null.
  - 409 Conflict if `sha` is stale.
  - 422 Validation failed if required body fields are missing.
  - 503 Service unavailable.

**Constraints**:
  - Same sequential write constraint as Create or update.
  - The `workflow` scope is required to modify files in `.github/workflows`.

**Auth**:
  - Fine-grained tokens: "Contents" repository permissions (write).
  - Classic tokens: `repo` scope.

## Get repository README

```
GET /repos/{owner}/{repo}/readme
GET /repos/{owner}/{repo}/readme/{dir}
```

[Formal signature](https://docs.github.com/en/rest/repos/contents?apiVersion=2026-03-10#get-a-repository-readme--parameters) | [For directory](https://docs.github.com/en/rest/repos/contents?apiVersion=2026-03-10#get-a-repository-readme-for-a-directory--parameters)

Returns the preferred README file from the repo root, or from a specific subdirectory via the `{dir}` variant.

**Parameters** (**Query string**):

- `ref` (optional): Branch, tag, or commit SHA. Defaults to the repo's default branch.

**Custom headers**:
  - `application/vnd.github.raw+json`: Raw file content (default).
  - `application/vnd.github.html+json`: HTML-rendered markup.
  - Note: `application/vnd.github.object+json` is not listed for this endpoint, unlike Get repository content.

**Response**:
  - 200 OK. Returns the same file object as Get repository content (including `download_url`).
  - 304 Not modified.
  - 404 if no README found.
  - 422 Validation failed.

**Auth**:
  - Fine-grained tokens: "Contents" repository permissions (read).
  - No auth needed for public repos.

## Download repository archive

```
GET /repos/{owner}/{repo}/tarball/{ref}
GET /repos/{owner}/{repo}/zipball/{ref}
```

Returns:

- A 302 redirect to a temporary download URL.
- Omitting `ref` uses the default branch.

Constraints:
  - For private repos, the redirect link expires after 5 minutes.
  - Your HTTP client must follow redirects.

## Constraints and Gotchas

- **One file per commit**: Each PUT/DELETE = one commit.
  - No atomic multi-file commits.
  - Bulk operations produce multiple commits.
- **Base64 everywhere**: Content is Base64-encoded in both request and response.
- **Rate limiting**: Standard GitHub REST limits (5,000 req/hr authenticated).
- **Sequential writes**: Parallel create/update/delete requests are not supported.
- **Concurrency control via SHA**: Updates and deletes require the current blob SHA. Stale SHA = 409 Conflict.

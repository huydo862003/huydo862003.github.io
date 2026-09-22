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

## Get repository content

```
GET /repos/{owner}/{repo}/contents/{path}
```

Returns the contents of a file or directory. Omitting `path` returns root directory contents.

- For files: returns metadata + Base64-encoded content
- For directories: returns an array of entry objects
- For symlinks: returns the target file content if the target is a normal file
- For submodules: returns `submodule_git_url` and the pinned commit SHA

Parameters:

- `ref` (optional): Branch, tag, or commit SHA. Defaults to the repo's default branch

Custom media types via `Accept` header:

- `application/vnd.github.raw+json`: Raw file content
- `application/vnd.github.html+json`: HTML-rendered markup
- `application/vnd.github.object+json`: Consistent object format regardless of content type

Size limits:

- <= 1 MB: Full content inline
- 1-100 MB: Only works with `raw` or `object` media types (`content` field is empty with `object`)
- \> 100 MB: Not supported, use Git LFS

Directory limit is 1,000 files. For larger directories, use the Git Trees API.

## Create or update file contents

```
PUT /repos/{owner}/{repo}/contents/{path}
```

Creates a new file or replaces an existing one. Each call produces exactly one commit.

Request body:

- `message` (required): Commit message
- `content` (required): Base64-encoded file content
- `sha` (required for updates): Blob SHA of the file being replaced. Acts as optimistic concurrency control; if the file changed since you last read it, the request fails with 409 Conflict
- `branch` (optional): Defaults to the repo's default branch
- `committer` (optional): `{ name, email, date }`. Defaults to the authenticated user
- `author` (optional): `{ name, email, date }`. Defaults to committer

::: warning
Do not make parallel PUT/DELETE requests. They must be sequential.
:::

## Delete a file

```
DELETE /repos/{owner}/{repo}/contents/{path}
```

Request body:

- `message` (required): Commit message
- `sha` (required): Blob SHA of the file to delete
- `branch` (optional): Defaults to the repo's default branch
- `committer` (optional): `{ name, email }`
- `author` (optional): `{ name, email }`

::: warning
Do not make parallel PUT/DELETE requests. They must be sequential.
:::

## Get repository README

```
GET /repos/{owner}/{repo}/readme
GET /repos/{owner}/{repo}/readme/{dir}
```

Returns the preferred README for the repo or a specific directory. Supports `ref` param and the same custom media types as Get repository content.

## Download repository archive

```
GET /repos/{owner}/{repo}/tarball/{ref}
GET /repos/{owner}/{repo}/zipball/{ref}
```

Returns a 302 redirect to a temporary download URL. Omitting `ref` uses the default branch.

For private repos, the redirect link expires after 5 minutes. Your HTTP client must follow redirects.

## Constraints and gotchas

- **One file per commit**: Each PUT/DELETE = one commit. No atomic multi-file commits. Bulk operations produce multiple commits
- **Base64 everywhere**: Content is Base64-encoded in both request and response
- **Rate limiting**: Standard GitHub REST limits (5,000 req/hr authenticated)
- **Sequential writes**: Parallel create/update/delete requests are not supported
- **Optimistic locking via SHA**: Updates and deletes require the current blob SHA. Stale SHA = 409 Conflict

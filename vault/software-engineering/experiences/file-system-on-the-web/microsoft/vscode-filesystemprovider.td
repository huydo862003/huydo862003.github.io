---
_type: ExperienceResource
_label: "VS Code FileSystemProvider"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://code.visualstudio.com/api/references/vscode-api#FileSystemProvider"
kind: 'article'
tags:
  - 'api'
---

The `FileSystemProvider` interface in VS Code.

Extensions implement it to serve files from arbitrary sources (FTP, remote servers, virtual filesystems).

::: tip
- **No separate `createFile`**: File creation is just `writeFile` with `{ create: true }`. Keeps the API surface small.
- **Bytes, not strings**: Content is `Uint8Array`, not text. The FS layer doesn't care about encoding.
- **Options objects for flags**: `{ create, overwrite, recursive }` instead of mode bits or separate methods. Readable and extensible.
- **Watch is first-class**: Built into the FS interface, not bolted on. If we need realtime updates, this is a good model.
- **`stat` is separate from `readFile`**: Metadata and content are fetched independently. Useful when you only need to check if a file exists or get its mtime.
:::

## Interface

All methods take a `Uri` and return `void` or `Thenable<void>` (async-capable). Errors are thrown as typed exceptions.

### Related types

```ts
enum FileType { Unknown = 0, File = 1, Directory = 2, SymbolicLink = 64 }

interface FileStat {
  type: FileType;    // Bitmask, e.g. FileType.File | FileType.SymbolicLink
  ctime: number;     // Creation time (ms since epoch)
  mtime: number;     // Modification time (ms since epoch)
  size: number;      // Size in bytes
  permissions?: FilePermission;  // e.g. readonly
}
```

### Read operations

- `stat(uri)` -> `FileStat`: Metadata (type, ctime, mtime, size, permissions).
  - For symlinks: return the target's metadata, but OR the type with `FileType.SymbolicLink`.
- `readFile(uri)` -> `Uint8Array`: Entire file content as bytes.
- `readDirectory(uri)` -> `Array<[string, FileType]>`: Entries as name/type tuples.

### Write operations

- `writeFile(uri, content, { create, overwrite })`: Write entire file content, replacing everything.
  - New files are created through this method (no separate `createFile`).
  - Throws `FileNotFound` if parent is missing or if file doesn't exist and `create` is false.
  - Throws `FileExists` if file exists and `overwrite` is false.
- `createDirectory(uri)`: Create a directory.
  - No mkdirp semantics: parent must already exist.
  - Throws `FileNotFound` if parent is missing.
- `delete(uri, { recursive })`: Delete a file or directory.
- `rename(oldUri, newUri, { overwrite })`: Move/rename a file or directory.
- `copy(source, destination, { overwrite })` (optional): Speeds up copy if implemented; otherwise VS Code falls back to read + write.

### Watch

- `watch(uri, { recursive, excludes })` -> `Disposable`: Subscribe to file change events.
  - `excludes` can be absolute paths, relative paths, or simple globs (e.g. `**/build`).
  - Case-sensitivity depends on the underlying OS (case-insensitive on Windows/macOS, case-sensitive on Linux).
  > Remark: It's one way to tackle realtime collaboration :v
- `onDidChangeFile` (event): Fires on create, change, or delete of watched resources.
  - Metadata must include updated `mtime` and correct `size` for the editor to display properly.

## Error model

All methods throw typed errors:

- `FileNotFound`: Resource or parent doesn't exist.
- `FileExists`: Resource already exists (when overwrite is false).
- `NoPermissions`: Insufficient permissions.

> No error codes, no status objects, just typed exceptions with clear semantics.

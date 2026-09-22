---
_type: ExperienceResource
_label: "PostgreSQL: Storing Files in the Database"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://wiki.postgresql.org/wiki/BinaryFilesInDB"
kind: 'article'
tags:
  - 'file'
---

> We don't really store binary files though... But large text files should hold too.

::: tip
**Quick guide**:
- Plain text files -> `text` column. No encoding overhead, string operations for free.
- Small binary files (under a few MB) -> `bytea` column. Standard SQL, no OID tracking.
- Large binary files needing streaming/seeking -> Large Objects. Different API, manual lifecycle.
- Very large files (100 MB+) or high throughput -> Store on filesystem, keep metadata + path in DB.
- Always store alongside: Original filename, MIME type, description, date added.
:::

Two approaches to handling binary files with PostgreSQL:

- Store them in the database, or store metadata.
- Store path in the database and keep files on the filesystem.

## Approach 1: Store files in the database

PostgreSQL offers three ways to store file data.

They differ in:

- How the data is stored internally.
- What API you use.
- What size/performance tradeoffs they make.

### `bytea`

A column type that stores raw bytes inline in a table row.

PostgreSQL's equivalent of MySQL's `BLOB`.

Properties:

- The data lives in the same table as your other columns, managed by TOAST (The Oversized-Attribute Storage Technique) for values > 2 KB.

Pros:

- Standard SQL interface (`INSERT`, `UPDATE`, `SELECT`).
- No storage overhead: PostgreSQL stores the raw bytes as-is on disk.
- Transfer overhead only: Client must escape binary data to send over the SQL wire protocol (hex or escape format). The DB decodes it back to raw bytes before storing. This is different from `text`'s 30% overhead, which is actual storage overhead.
  - Some languages (Python, .NET) handle this automatically.

Cons:
  - Limited to 1 GB per entry, 4 billion (> 2 KB) entries per table.
  - Entire value loaded into server memory on read. No partial reads or seeking. Under concurrent connections, this adds up fast (e.g. 100 queries x 5 rows x 2 MB = ~1 GB just for those reads).

Desired use cases:

- Files are small-to-medium (under a few MB).
- A simple SQL interface, and you don't need streaming.

::: note
The wiki author switched to using `bytea` exclusively. It is the recommended choice over `text` and Large Objects for most use cases.
:::

### `text`

A column type that stores character data with encoding validation (UTF-8).

Properties:

- Same internal storage as `bytea` (TOAST-backed, same 1 GB / 4 billion limits).
- The DB treats the content as text, not opaque bytes.

Pros:

- Standard SQL interface.
- Storage is ~30% higher than the original file when used for binary data (must encode as Base64, uuencode, etc.).
- For actual text content, there is no encoding overhead since it is already text.
- Gives you string operations (`LIKE`, regex, full-text search) that `bytea` does not.

Cons:

- Same memory constraints as `bytea`: entire value loaded on read.

Desired use cases:

- Storing actual text content (not binary).
- You get string operations for free and no encoding overhead.

### Large Objects (BLOB)

A separate storage system in PostgreSQL.

Properties:

- Files are stored outside of normal tables in a system-managed `pg_largeobject` table.
- Each file gets an OID (Object Identifier) that you reference from your own tables.

Pros:

- Up to 4 TB per entry (PostgreSQL 9.3+), 4 billion per database. The 4 TB limit comes from the Large Object API's 64-bit seek offset; the 4 billion limit comes from OIDs being 32-bit. Still lower than typical filesystem limits (ext4: 16 TB/file, XFS: 8 EB/file). The DB is always the bottleneck, not the filesystem.
- Supports streaming and seeking (read/write arbitrary byte ranges without loading the whole file).
- No encoding/escaping needed.

Cons:

- Completely different API from normal SQL. Uses `lo_create`, `lo_open`, `lo_read`, `lo_write`, etc.
- Must track OIDs manually. Your table only stores the OID (an integer), not the file. You need a separate metadata table mapping OIDs to file records.
- OIDs are dumb references, no refcounting. Deleting a row does not delete the Large Object it points to. You must explicitly call `lo_unlink(oid)`. Orphaned objects accumulate silently; PostgreSQL ships `vacuumlo` specifically to clean them up.
- No access controls in older versions (< 9.0).

Desired use cases:

- Files are very large and you need partial reads/seeks (e.g. streaming video, large archives).
- Overkill for small files.

### General tradeoffs of in-database storage

Pros:

- Security and access control in one place.
- ACID guarantees for files alongside their metadata.
- Files replicate to standby automatically.
- Backups include everything, no need to track external files.

Cons:

- Performance hit compared to direct filesystem access.
- Higher memory requirements.
- Longer backups.
- External applications cannot access files directly; must go through the DB.

## Approach 2: Store metadata + path in the database

Keep files on the filesystem, store only metadata and a path/link in the database.

Pros:

- Faster access (skips DB layer).
- No size limits beyond the filesystem.

Cons:

- DB and filesystem can get out of sync (deleted files, moved files, stale paths).
- DB user needs filesystem write permissions (not always available in hosted environments).
- Security is split between filesystem and database.

**When to store files in the database**:

- When ACID matters for the files themselves.

**When not to store files in the database**:

- Very large files (100 MB+) where performance is critical.
- The database layer adds overhead that may not be justified.

**Recommended metadata to store alongside files**:

- Original filename.
- MIME type (following Internet Media Type standard, useful for web serving and email attachments).
- Description.
- Date added.

## Takeaways for our system

- Our files are plain text, up to 20k LOC (around 1-2 MB). Still within the range where in-database storage is acceptable.
- The wiki is framed around binary files, but the TOAST constraints (1 GB per entry, 4 billion entries) apply equally to `text` and `bytea`. At 1-2 MB per file, TOAST handles this transparently (compresses and stores out-of-line for values > 2 KB).
- For plain text, `text` is the more natural choice over `bytea`. No encoding overhead (the 30% overhead only applies when encoding binary data as text). You also get string operations for free (`LIKE`, regex, full-text search).
- The only caveat: entire value is read into memory on `SELECT`. No partial reads with `text`/`bytea` (only Large Objects support seeking). At 1-2 MB this is fine.
- The main tradeoff: in-DB gives us ACID and simpler backups, but makes it harder for external tools to access files directly.

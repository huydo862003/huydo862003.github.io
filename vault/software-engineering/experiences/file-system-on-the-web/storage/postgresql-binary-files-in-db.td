---
_type: ExperienceResource
_label: "PostgreSQL: Storing Files in the Database"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://wiki.postgresql.org/wiki/BinaryFilesInDB"
kind: 'article'
tags:
  - 'file'
---

Two approaches to handling binary files with PostgreSQL: store them in the database, or store metadata + path in the database and keep files on the filesystem.

## Approach 1: Store files in the database

Three storage types available:

### `bytea`

- Uses standard SQL (`INSERT`, `UPDATE`, `SELECT`).
- Storage size same as the original file.
- Limited to 1 GB per entry (uses TOAST internally).
- Requires escaping/encoding before sending to DB, then decoding on retrieval.
  - Some languages (Python, .NET) handle this automatically.
- Memory requirements on the server can be steep even for small record sets.

### `text`

- Also standard SQL, also uses TOAST (1 GB limit).
- Storage is ~30% higher than the original file (encoding overhead).
- Must always encode/decode (Base64, uuencode, etc.).

### Large Objects (BLOB)

- Up to 4 TB per entry (PostgreSQL 9.3+), 4 billion per database.
- Supports streaming and seeking (can reduce memory requirements).
- No encoding/escaping needed.
- Different API from normal SQL (not `INSERT`/`SELECT`).
- Must track OIDs manually (usually a separate metadata table).
- Only needed if entries are large enough to require partial reads.

### General pros of in-database storage

- Security and access control in one place.
- ACID guarantees for files alongside their metadata.
- Files replicate to standby automatically.
- Backups include everything, no need to track external files.

### General cons

- Performance hit compared to direct filesystem access.
- Higher memory requirements.
- Longer backups.
- External applications cannot access files directly; must go through the DB.

## Approach 2: Store metadata + path in the database

Keep files on the filesystem, store only metadata and a path/link in the database.

- Faster access (skips DB layer).
- No size limits beyond the filesystem.
- But: DB and filesystem can get out of sync (deleted files, moved files, stale paths).
- DB user needs filesystem write permissions (not always available in hosted environments).
- Security is split between filesystem and database.

## When to store files in the database

When ACID matters for the files themselves. The wiki gives the example of quality inspection photos: the photos are part of the inspection record, and losing the link between them makes both worthless. Storing in DB guarantees they stay together through backups, replication, and migrations.

## When not to

Very large files (100 MB+) where performance is critical. The database layer adds overhead that may not be justified.

## Takeaways for our system

- Our files are plain text, not binary, and mostly under 100 KB. This is well within the range where in-database storage is acceptable.
- `bytea` is the practical choice if we store in DB. Standard SQL, no OID tracking, same storage size.
- The main tradeoff: in-DB gives us ACID and simpler backups, but makes it harder for external tools to access files directly.

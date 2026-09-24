---
_type: SoftEngFlashcard
deck: 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-toast.td")
  - fref("software-engineering/concepts/postgresql-bytea.td")
  - fref("software-engineering/concepts/postgresql-text.td")
  - fref("software-engineering/concepts/postgresql-large-objects.td")
  - fref("software-engineering/concepts/mongodb-gridfs-concept.td")
---

::: flashcard
What is PostgreSQL TOAST?
=== The Oversized-Attribute Storage Technique. When a column value exceeds ~2 KB, PostgreSQL automatically compresses and/or moves it to a separate TOAST table. Happens transparently. Limits: 1 GB per value, 4 billion (> 2 KB) entries per table.
:::

::: flashcard
What is the difference between `bytea` and `text` for storing files in PostgreSQL?
=== `bytea` stores raw bytes (no encoding assumptions). `text` stores character data (UTF-8 validated). For plain text files, `text` is the natural choice (no encoding overhead, string operations for free). For binary files, `bytea` (same storage size as the original file). Both use TOAST with the same 1 GB / 4 billion limits.
:::

::: flashcard
When should you use PostgreSQL Large Objects over `bytea`?
=== Only when files are very large and you need streaming/seeking (partial reads). Large Objects support up to 4 TB per entry and arbitrary byte-range access. The tradeoff: Different API (lo_create, lo_open, etc.), manual OID tracking, no refcounting (must call lo_unlink explicitly, orphans accumulate silently).
:::

::: flashcard
What is the storage overhead of `bytea` vs `text` for binary data?
=== `bytea` has no storage overhead (raw bytes stored as-is). Only transfer overhead (escaping for the SQL wire protocol, decoded before storing). `text` has ~30% storage overhead for binary data because it must be Base64 encoded. For actual text content, `text` has no overhead.
:::

::: flashcard
What is MongoDB GridFS and when should you use it?
=== MongoDB's specification for storing files exceeding the 16 MB BSON limit. Splits files into chunks across `fs.files` (metadata) and `fs.chunks` (data) collections. Use for files > 16 MB or when you need streaming/seeking. For files under 16 MB, just store as BinData in a normal document.
:::

::: flashcard
What happens when you delete a row that references a PostgreSQL Large Object?
=== Nothing. The Large Object is NOT deleted. OIDs are dumb references with no refcounting. You must explicitly call `lo_unlink(oid)`. Orphaned objects accumulate silently. PostgreSQL ships `vacuumlo` to clean them up.
:::

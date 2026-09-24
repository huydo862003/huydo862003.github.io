---
_type: SoftEngConcept
_label: 'PostgreSQL bytea'
journey: fref("software-engineering/index.td")
status: 'learning'
depends_on:
  - fref("software-engineering/concepts/postgresql-toast.td")
tags:
  - 'database'
---

A PostgreSQL column type that stores raw bytes inline in a table row. The equivalent of MySQL's BLOB.

## Properties

- Standard SQL interface (INSERT, UPDATE, SELECT).
- No storage overhead: PostgreSQL stores the raw bytes as-is on disk.
- Transfer overhead only: Client must escape binary data for the SQL wire protocol. The DB decodes it back before storing.
- Uses TOAST internally (1 GB per entry, 4 billion entries per table).
- Entire value loaded into server memory on read. No partial reads or seeking.

## When to Use

- Small to medium binary files (under a few MB).
- You want a simple SQL interface without OID tracking.

## bytea vs text for File Storage

- `bytea` is for binary data. No encoding assumptions.
- `text` is for character data (UTF-8 validated). No encoding overhead for actual text. Gives you string operations (LIKE, regex, full-text search) for free.
- For plain text files, `text` is the natural choice. For binary files, `bytea`.

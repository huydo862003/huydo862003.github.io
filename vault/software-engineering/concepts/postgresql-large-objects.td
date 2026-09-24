---
_type: SoftEngConcept
_label: 'PostgreSQL Large Objects'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'database'
---

A separate storage system in PostgreSQL for large binary data. Files are stored in the system-managed `pg_largeobject` table, referenced by OID.

## Properties

- Up to 4 TB per entry (PostgreSQL 9.3+). The limit comes from the 64-bit seek offset.
- 4 billion objects per database (OIDs are 32-bit).
- Supports streaming and seeking (read/write arbitrary byte ranges).
- No encoding or escaping needed.

## Downsides

- Completely different API from normal SQL (uses `lo_create`, `lo_open`, `lo_read`, `lo_write`).
- Must track OIDs manually (a separate metadata table mapping OIDs to file records).
- OIDs are dumb references with no refcounting. Deleting a row does not delete the Large Object. Must call `lo_unlink(oid)` explicitly. PostgreSQL ships `vacuumlo` to clean up orphans.

## When to Use

- Files are very large and you need partial reads or seeking.
- Overkill for small files. Use `bytea` or `text` instead.

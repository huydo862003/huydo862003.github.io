---
_type: SoftEngConcept
_label: 'PostgreSQL text'
journey: fref("software-engineering/index.td")
status: 'learning'
depends_on:
  - fref("software-engineering/concepts/postgresql-toast.td")
tags:
  - 'database'
---

A PostgreSQL column type that stores character data with UTF-8 encoding validation.

## Properties

- Standard SQL interface (INSERT, UPDATE, SELECT).
- Same TOAST limits as `bytea` (1 GB per entry, 4 billion entries per table).
- The DB validates encoding on insert.
- No encoding overhead when storing actual text content.
- ~30% storage overhead when used to store binary data (must Base64 encode).
- Gives you string operations for free: LIKE, regex, full-text search.

## When to Use

- Storing actual text content (source code, config files, documents).
- You need string operations on the stored content.
- Not for binary data (use `bytea` instead).

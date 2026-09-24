---
_type: SoftEngConcept
_label: 'PostgreSQL TOAST'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'database'
---

The Oversized-Attribute Storage Technique. PostgreSQL's mechanism for handling large column values that exceed the page size (8 KB).

## How It Works

- When a row contains a value larger than ~2 KB, PostgreSQL automatically compresses it and/or moves it to a separate TOAST table.
- This happens transparently. The application does not need to know about TOAST.
- The original row stores a pointer to the TOAST table.

## Limits

- Maximum 1 GB per value.
- Maximum 4 billion (> 2 KB) entries per table.

## What Uses TOAST

- `bytea` columns (raw bytes).
- `text` columns (character data).
- `jsonb` columns.
- Any variable-length type that can exceed ~2 KB.

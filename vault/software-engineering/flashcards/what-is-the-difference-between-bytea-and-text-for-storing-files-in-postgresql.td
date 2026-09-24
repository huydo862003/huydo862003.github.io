---
_type: SoftEngFlashcard
_label: 'What is the difference between `bytea` and `text` for storing files in PostgreSQL?'
deck: 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-bytea.td")
  - fref("software-engineering/concepts/postgresql-text.td")
---

::: flashcard
What is the difference between `bytea` and `text` for storing files in PostgreSQL?
=== key
`bytea` stores raw bytes (no encoding assumptions). `text` stores character data (UTF-8 validated). For plain text files, `text` is the natural choice (no encoding overhead, string operations for free). For binary files, `bytea` (same storage size as the original file). Both use TOAST with the same 1 GB / 4 billion limits.
:::

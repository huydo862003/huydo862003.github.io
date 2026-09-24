---
_type: SoftEngFlashcard
_label: 'What is PostgreSQL TOAST?'
deck: 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-toast.td")
---

::: flashcard
What is PostgreSQL TOAST?
=== key
The Oversized-Attribute Storage Technique. When a column value exceeds ~2 KB, PostgreSQL automatically compresses and/or moves it to a separate TOAST table. Happens transparently. Limits: 1 GB per value, 4 billion (> 2 KB) entries per table.
:::

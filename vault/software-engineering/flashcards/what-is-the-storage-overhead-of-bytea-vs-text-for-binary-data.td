---
_type: SoftEngFlashcard
_label: 'What is the storage overhead of `bytea` vs `text` for binary data?'
deck: 'database'
tags:
  - 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-bytea.td")
  - fref("software-engineering/concepts/postgresql-text.td")
---

::: flashcard
What is the storage overhead of `bytea` vs `text` for binary data?
=== key
`bytea` has no storage overhead (raw bytes stored as-is). Only transfer overhead (escaping for the SQL wire protocol, decoded before storing). `text` has ~30% storage overhead for binary data because it must be Base64 encoded. For actual text content, `text` has no overhead.
:::

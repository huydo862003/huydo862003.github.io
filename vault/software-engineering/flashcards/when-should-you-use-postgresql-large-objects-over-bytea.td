---
_type: SoftEngFlashcard
_label: 'When should you use PostgreSQL Large Objects over `bytea`?'
deck: 'database'
tags:
  - 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-large-objects.td")
---

::: flashcard
When should you use PostgreSQL Large Objects over `bytea`?
=== key
Only when files are very large and you need streaming/seeking (partial reads). Large Objects support up to 4 TB per entry and arbitrary byte-range access. The tradeoff: Different API (lo_create, lo_open, etc.), manual OID tracking, no refcounting (must call lo_unlink explicitly, orphans accumulate silently).
:::

---
_type: SoftEngFlashcard
_label: 'What happens when you delete a row that references a PostgreSQL Large Object?'
deck: 'database'
tags:
  - 'database'
concepts:
  - fref("software-engineering/concepts/postgresql-large-objects.td")
---

::: flashcard
What happens when you delete a row that references a PostgreSQL Large Object?
=== key
Nothing. The Large Object is NOT deleted. OIDs are dumb references with no refcounting. You must explicitly call `lo_unlink(oid)`. Orphaned objects accumulate silently. PostgreSQL ships `vacuumlo` to clean them up.
:::

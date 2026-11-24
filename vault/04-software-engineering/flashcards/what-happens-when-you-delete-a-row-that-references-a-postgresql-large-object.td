---
_type: SoftEngFlashcard
_label: 'What happens when you delete a row that references a PostgreSQL Large Object?'
tags:
  - 'database'
concepts:
  - fref("/04-software-engineering/concepts/postgresql-large-objects.td")
---

::: flashcard{deck="database"}
What happens when you delete a row that references a PostgreSQL Large Object?
=== key
Nothing. The Large Object is NOT deleted. OIDs are dumb references with no refcounting. You must explicitly call `lo_unlink(oid)`. Orphaned objects accumulate silently. PostgreSQL ships `vacuumlo` to clean them up.
:::

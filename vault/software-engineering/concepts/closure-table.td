---
_type: SoftEngConcept
journey: fref("software-engineering/index.td")
status: 'learning'
depends_on:
  - fref('software-engineering/concepts/transitive-closure.td')
tags:
  - 'database'
---

A closure table is a DB pattern for storing the transitive closure of a directed graph. It uses a separate table with two columns `(ancestor, descendant)`, containing one row for every reachable pair, including self-referencing rows `(x, x)`.

```sql
CREATE TABLE closure (
  ancestor   uuid NOT NULL,
  descendant uuid NOT NULL,
  PRIMARY KEY (ancestor, descendant)
);
```

- `READ [id]`: `SELECT descendant FROM closure WHERE ancestor = id`.
- `UPDATE-DIRECT [id] [new-id-list]`: Delete all rows where ancestor paths pass through `id`, then reinsert.
- `DELETE [id]`: Remove all rows involving `id` as ancestor or descendant.

The tradeoff: `READ` is O(1) (a single indexed query), but `UPDATE-DIRECT` and `DELETE` require recomputing all affected ancestor-descendant pairs, which can be expensive for deep or wide graphs.

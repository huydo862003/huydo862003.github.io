---
_type: SoftEngConcept
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'database'
---

A recursive query uses SQL's `WITH RECURSIVE` to traverse hierarchical or graph-structured data within the DB, without fetching rows into application code.

```sql
WITH RECURSIVE reachable AS (
  -- Base case: direct-use
  SELECT used_id AS id FROM direct_use WHERE diagram_id = $root
  UNION ALL
  -- Recursive case: follow edges
  SELECT d.used_id FROM direct_use d
  JOIN reachable r ON d.diagram_id = r.id
)
SELECT id FROM reachable;
```

- The base case seeds the result set with directly reachable nodes.
- The recursive case joins the result so far back against the edge table to expand one more hop.
- The DB repeats until no new rows are added (fixed point).

This is equivalent to computing transitive closure on-the-fly. It avoids storing the closure explicitly, but costs a full graph traversal on every `READ`.

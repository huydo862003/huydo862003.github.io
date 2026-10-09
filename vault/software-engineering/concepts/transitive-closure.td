---
_type: SoftEngConcept
journey: fref("software-engineering/index.td")
status: 'learning'
blocks:
  - fref('software-engineering/concepts/closure-table.td')
tags:
  - 'database'
---

Given a directed graph `G = (V, E)`, the transitive closure of `G` is a new graph `G* = (V, E*)` where `(u, v) in E*` if and only if there is a path from `u` to `v` in `G`.

In plain terms: `G*` tells you which nodes are reachable from which, regardless of how many hops it takes.

## In Databases

The transitive closure problem appears whenever data has hierarchical or dependency relationships:

- File import graphs (diagram A uses B, B uses C -> A transitively uses C).
- Org charts (find all reports under a manager).
- Category trees (find all subcategories of a category).

The challenge is not computing it once, but maintaining it incrementally as edges are added, updated, or removed.

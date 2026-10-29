---
_type: Experience
_label: "Storing & Querying Transitively Imported Files in the Cloud"
status: "active"
---

As stated in ${fref("/software-engineering/experiences/file-system-on-the-web/index.td")}, we're building multifile support into dbdiagram (a cloud-based app). That experience mainly revolves around the large problem as a whole.

This experience, though, will focus on a much more narrow problem: storing, querying and updating transitive closure in a database, and why we ended up not doing that.

## Context

In DBML, we support the `use` syntax to allow importing schema elements from another DBML file (also called a DBML diagram).

```dbml
// diagram-a.dbml

use * from './diagram-b'
use * from './diagram-c'

// diagram-b.dbml

use * from './diagram-b1'
use * from './diagram-b2'
use * from './diagram-a'   // circular import

// diagram-c.dbml

use * from './diagram-c1'
use * from './diagram-c2'
```

As a side note, DBML use is not transitive by default: `./diagram-a.dbml` will not see `./diagram-b1.dbml` declarations via `diagram-b.dbml`. Nevertheless, when rendering `diagram-a`, we still need `diagram-b1` available so we can have all global information to process the diagram.

Note that cycles are possible (B uses A, and A uses B). The system must handle them gracefully.

## Our Problem

Currently, in dbdiagram, we do not fetch all diagrams up-front. On startup, we fetch two things:

- The current diagram by a given id.
- The diagram listing.

A naive approach to support the `use` syntax is this (assuming the code in the preceding section):

1. User enters URL for diagram A.
2. The client fetches diagram A.
3. The client parses diagram A and discovers it uses diagram B and diagram C.
4. The client fetches diagram B and diagram C (concurrently).
5. The client parses diagram B and C and discovers 4 more.
6. And so on, until the whole import graph has been discovered.

${fref("./_assets/index-1791536683.png")}

This leaves a lot to be desired:

- API waterfall: The using diagram must be fetched and parsed before the used diagrams, because before parsing we have no way to know which diagrams to fetch next. This leads to a chain of sequential API calls, as deep as the import graph.
- Many DB queries on each startup, proportional to graph size.

## Generalizing the Problem

The diagram import graph is a directed graph where each node is a diagram and each edge is a direct-use relation. Fetching all diagrams that a diagram transitively uses is exactly computing the **transitive closure** of that node.

::: details What Is Transitive Closure?
Given a directed graph $G = (V, E)$, the transitive closure $G^* = (V, E^*)$ satisfies: $(u, v) \in E^*$ if and only if there is a path from $u$ to $v$ in $G$.

In plain terms: $G^*$ tells you which nodes are reachable from which, regardless of how many hops it takes.
:::

In terms of operations, we need:

- `UPDATE-DIRECT [id] [new-id-list]`: Sets the direct-used diagrams of `id` to `new-id-list`. Called on every save.
- `READ [id]`: Returns all transitively-used diagram ids for `id`. Called on startup.

> `READ` is called far less often than `UPDATE-DIRECT`, so we prefer `READ` to be fast even if `UPDATE-DIRECT` costs more.

## The Core Tension

There is no known scheme that makes both `READ` (fetch all transitive imports) and `UPDATE` (change direct imports) simultaneously cheap. Every approach picks a point on the **precompute-on-write vs compute-on-read** spectrum.

### Adjacency List + Recursive Query

Each node stores only its direct dependencies. On read, a ${fref("/software-engineering/concepts/recursive-query.td")} (recursive CTE in SQL, `$graphLookup` in MongoDB) traverses the graph hop by hop.

```
nodes table
+----+----------+
| id | uses     |
+----+----------+
| A  | [B, C]   |
| B  | [B1, B2] |
| C  | [C1, C2] |
+----+----------+
```

- `UPDATE-DIRECT` is O(1): a single field update.
- `READ` is O(depth): each hop is a join, and query time grows with graph depth.
- Cycles must be tracked with a visited set; PostgreSQL has a default recursion limit of 100.

### Path Enumeration

Each node stores a materialized path encoding its full ancestry, e.g. `/root/a/b/c`.

```
nodes table
+----+-------------+
| id | path        |
+----+-------------+
| A  | /A          |
| B  | /A/B        |
| B1 | /A/B/B1     |
| B2 | /A/B/B2     |
| C  | /A/C        |
| C1 | /A/C/C1     |
+----+-------------+
  READ B's subtree: WHERE path LIKE '/A/B/%'
```

- `UPDATE-DIRECT` is O(subtree): moving a node rewrites every descendant's path.
- `READ` is O(1): a prefix scan returns all descendants.
- Assumes a tree, not a DAG: a node with multiple parents cannot be represented. Cycles are not supported.

### Nested Sets

Each node has a `lft` and `rgt` integer. A node is a descendant of another iff its range falls inside the ancestor's range.

```
nodes table                        the tree
+----+-----+-----+
| id | lft | rgt |            A [1,12]
+----+-----+-----+          /        \
| A  |  1  | 12  |     B [2,7]     C [8,11]
| B  |  2  |  7  |     /    \       /    \
| B1 |  3  |  4  |  B1[3,4] B2[5,6] C1[9,10]
| B2 |  5  |  6  |
| C  |  8  | 11  |  READ B's subtree:
| C1 |  9  | 10  |    WHERE lft > 2 AND rgt < 7
+----+-----+-----+
```

- `UPDATE-DIRECT` is O(n): inserting a node shifts ranges for every node to its right.
- `READ` is O(1): a single `BETWEEN` range query.
- Trees only. Cycles are not supported.

### Closure Table

A separate table stores one row for every reachable `(ancestor, descendant, depth)` pair. The main table stays simple.

```
nodes table          closure table
+----+------+        +----------+------------+-------+
| id | name |        | ancestor | descendant | depth |
+----+------+        +----------+------------+-------+
| A  | ...  |        | A        | A          |  0    |
| B  | ...  |        | A        | B          |  1    |
| B1 | ...  |        | A        | B1         |  2    |
+----+------+        | A        | B2         |  2    |
                      | B        | B          |  0    |
                      | B        | B1         |  1    |
                      | B        | B2         |  1    |
                      | ...      | ...        | ...   |
                      +----------+------------+-------+
  READ A's subtree: SELECT descendant FROM closure
                    WHERE ancestor = 'A'
```

- `UPDATE-DIRECT` is O(ancestors) on insert. Updating or moving a node requires deleting all affected pairs and reinserting recomputed ones.
- `READ` is O(1): a single indexed join.
- For DAGs, a node reachable via multiple paths makes the delete-and-reinsert logic considerably harder, since you must not remove pairs still reachable via another path.
- This logic is almost always delegated to triggers, which add hidden complexity and are difficult to test.
- Storage can grow up to $O(|V|^2)$ in the worst case.

For a thorough treatment, see Dong et al., *[Maintaining Transitive Closure of Digraphs in Polynomial Time](https://doi.org/10.1007/BF01187077)* (Algorithmica, 1999).

| Approach | `READ` | `UPDATE-DIRECT` | DAGs/Cycles? | Engineering cost |
|---|---|---|---|---|
| Adjacency list + recursive query | O(depth) | O(1) | Yes, with care | Moderate: recursive queries are non-trivial to debug |
| Path enumeration | O(1) | O(subtree) | No (trees only) | Low, but trees only |
| Nested sets | O(1) | O(n) | No (trees only) | High: range arithmetic is error-prone, trees only |
| Closure table | O(1) | O(ancestors), complex for DAGs | Partially | High: requires DB triggers to maintain, logic is DB-bound and hard to test |

Since no centralized, DB-only approach gives us both cheap reads and cheap writes without significant complexity, we looked for a way to sidestep the problem entirely.

## Our Approach: Spread the Cost to the Client

Since no DB-only scheme makes both operations cheap without significant complexity, we stop asking the database to compute the transitive closure at all. Instead, we:

- **Store only direct imports** in the DB. On save, the backend derives them from the diagram content. No transitive recomputation, no triggers, no cascading updates.
- **Resolve the closure in application code**, scoped to the workspace. The workspace's import graph is small enough to load into memory and walk with a simple BFS/DFS (with a visited set for cycles).
- **Batch-fetch** all resolved diagram contents in one request.

The flow becomes:

1. User opens a diagram.
2. Load the workspace's direct-import graph (a small metadata query).
3. Walk the graph in memory to compute the closure.
4. Batch-fetch all diagram contents in one request.

That is two DB queries regardless of graph depth, with no recursive SQL, no closure maintenance, and no cycle-handling complexity in the database layer.

### The Tradeoff

We are trading **some consistency** for simplicity and performance. Because we only store direct imports and compute the closure at read time, there is a brief window where a stale listing could produce an incomplete closure (e.g. if another user just changed their imports). In practice, this is acceptable: the listing refreshes on workspace visit, and a page reload resolves any staleness. The consistency window is short and the failure mode is benign (missing an import, not corrupting data).

### A Nice Side Effect

Storing raw import paths and resolving them against the current listing at read time means **renames and moves just work**. There are no stored IDs to go stale. The only cost is a slightly larger listing payload, amounting to a handful of short strings per diagram.

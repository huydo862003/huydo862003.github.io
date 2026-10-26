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

// diagram-c.dbml

use * from './diagram-c1'
use * from './diagram-c2'
```

As a side note, DBML use is not transitive by default: `./diagram-a.dbml` will not see `./diagram-b1.dbml` declarations via `diagram-b.dbml`. Nevertheless, when rendering `diagram-a`, we still need `diagram-b1` available so we can have all global information to process the diagram.

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

## DB Approaches and Their Limits

We initially framed this as a database problem. Research confirms there is no known solution that makes both `READ` and `UPDATE-DIRECT` O(1); every approach trades one against the other. Here is how that plays out across the standard approaches, along with the practical complexity each brings.

### Adjacency List With Recursive Queries

- **Schema:** Each node stores only its direct dependencies (a `parent_id` or `used_ids` array). Minimal storage; one row per node.
- **Read:** A recursive CTE traverses the graph hop by hop until no new nodes are discovered.
- **Write:** A single field update. Cheap.

```sql
WITH RECURSIVE tc AS (
  SELECT used_id FROM uses WHERE diagram_id = :id
  UNION ALL
  SELECT u.used_id FROM uses u JOIN tc ON tc.used_id = u.diagram_id
)
SELECT used_id FROM tc;
```

Drawbacks:

- Recursive CTEs are non-trivial to reason about and debug.
- Many databases have a default recursion limit (PostgreSQL defaults to 100 levels).
- Query time grows with graph depth, which is unpredictable at runtime.
- No index can accelerate the traversal itself; each hop is a join.

### Path Enumeration

- **Schema:** Each node stores a materialized path string encoding its full ancestry, such as `/root/a/b/c`.
- **Read:** A prefix scan (`WHERE path LIKE '/root/a/%'`) returns all descendants instantly.
- **Write:** Insert appends to the parent path. Move or rename must rewrite the path of every descendant via a string replace across the subtree.

Drawbacks:

- Assumes a tree, not a DAG: a node with multiple parents cannot be represented.
- Moves cascade path updates across the entire affected subtree.
- Path strings grow without bound for deep hierarchies.
- Does not handle cycles.

### Nested Sets

- **Schema:** Each node has a `lft` and `rgt` integer. A node is a descendant of another if and only if its range falls inside the ancestor's range.
- **Read:** A single `BETWEEN` range query returns the entire subtree. No recursion required.
- **Write:** Inserting a node shifts the `lft`/`rgt` of every node to its right by ±2. Moving a subtree is a multi-step operation requiring careful arithmetic, typically wrapped in a stored procedure.

Drawbacks:

- Every insert or move updates a large portion of the table, causing lock contention on large datasets.
- Only well-suited to trees, not arbitrary DAGs.
- `lft`/`rgt` values are opaque and nearly impossible to manage without stored procedures.

### Closure Table

- **Schema:** A separate `closure` table holds one row for every reachable pair `(ancestor, descendant, depth)`, including self-pairs. The main table stays simple.
- **Read:** A single indexed join against the closure table. No traversal needed.
- **Write:** Inserting a node adds one closure row per ancestor. Moving or updating a node requires deleting all affected pairs and reinserting recomputed ones. This logic is almost always delegated to triggers.

Drawbacks:

- For DAGs, the delete-and-reinsert logic is complex: a node can have multiple parents, so you must not remove pairs still reachable via a different path.
- Triggers keep the closure table in sync but add hidden complexity and are difficult to test.
- Storage grows as $O(|V|^2)$ in the worst case.

> No approach makes both `READ` and `UPDATE-DIRECT` cheap. Every DB-side solution picks a point on the precompute-on-write vs. compute-on-read spectrum, and none of them are simple.

## Stepping Back: Client-Side Resolution

::: warning
This only works in our cases because the diagram listing is usually small enough, so we can fetch them upfront... I'm still very much interested in a better approach.
:::

The real problem is not which DB schema to pick. It is that each level of the import graph costs a client-server round trip, because the client learns what to fetch next only by downloading and parsing content. The waterfall comes from the fact that the client does not know the shape of the graph before it has the contents.

The fix: give the client the graph's shape upfront. The diagram listing is already fetched at startup. We can include each diagram's direct-use paths there.

**How It Works**

When a diagram is saved, record its raw use paths (for example `['./diagram-b', './diagram-c']`) as a small metadata field. The client already parses on save, so it can send them along; alternatively, the backend can extract them. Return that field in the diagram listing.

Startup becomes:

1. Fetch diagram A and the listing in parallel, as today.
2. On the client, resolve A's use paths against the listing entries, then walk the full import graph in memory to compute the closure.
3. Batch-fetch everything in the closure in one request (`GET /diagrams?ids=...`).

That is two round trips regardless of graph depth, with no recursive queries and no closure maintenance on the server. Writes stay as cheap as they are today.

A useful side effect: storing raw paths and resolving them at read time against the current listing means renames and moves just work. There are no stored ids to go stale. The only cost is a slightly larger listing payload, amounting to a handful of short strings per diagram.

One step further: since A's own use paths are in the listing too, you can compute the full closure from the listing alone and batch-fetch A together with everything it uses. Startup collapses to one listing request followed by one content request.

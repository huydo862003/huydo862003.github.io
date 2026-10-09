---
_type: Experience
_label: "Transitive Closures in Database"
status: "active"
---

As stated in ${fref("software-engineering/experiences/file-system-on-the-web/index.td")}, we're building multifile support into dbdiagram (a cloud-based app). That experience mainly revolves around the large problem as a whole.

This experience, though, will focus on a much more narrow problem: Storing, querying and updating transitive closure in database.

## Context

In DBML, we support the `use` syntax to allows importing schema elements from another DBML file (also called DBML diagram).

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

As a side note, DBML use is not transitive by default: That means `./diagram-a.dbml` will not see `./diagram-b1.dbml` declaration via `diagram-b.dbml`. Nevertheless, when rendering `diagram-a`, we will still need `diagram-b1` to be available so we can have all possible global information to process the diagram.

## Our Problem

Currently, in dbdiagram, we do not fetch all diagrams up-front. On startup, we fetch two things:

- The current diagram by a given id.
- The diagram listing.

A naive approach that could support where a diagram could "use" other diagrams is this (assuming the same code in the preceding section):

1. User enters URL for diagram A.
2. The client (dbdiagram frontend) fetches diagram A.
3. The client parses diagram A and discovers it uses diagram B and diagram C.
4. The client fetches diagram B and diagram C (may be concurrently).
5. The client parses diagram B and C and discover 4 more.
6. And so on, until the whole import graph has been discovered.

${fref("./_assets/index-1791536683.png")}

This simple approach leaves a lot to be desired:

- API waterfall: The using diagram must be fetched and parsed before the used diagrams, because before that, we have no way to know which diagrams to fetch next. -> This leads to a chain of sequential API calls, as deep as the import graph.
- A lot of DB queries hit the database, at least for each API request.

We can mitigate these by fetching the diagram along with all of its transitively used diagrams.

So the problem reduces to: How do we know which diagrams a diagram transitively uses?

We limit the scope of the solution space to storing some additional information in the database. (Maybe there are other better and more sophisticated solutions outside of this domain)

## Problem Statement

Here's our specific problem statement:

::: note
Propose a DB schema design that supports the following operations efficiently:

- `UPDATE-DIRECT [id] [new-id-list]`: Sets the direct-used diagrams of diagram `id` to `new-id-list`.
- `READ [id]`: Returns all transitively-used diagram ids for `id`, which is the union of all direct-used diagrams, direct-used of direct-used, and so on.

Initially, the data structure returns an empty list for all ids.
:::

### Some (Insufficient) Approaches

Before deciding to research into this, I have spared some forethoughts into the possible approaches.

- **Approach 1 (Naive)**: The client fetches diagram A, parses it, then fetches newly discovered used diagrams sequentially.
  - `UPDATE-DIRECT` is zero-cost.
  - `READ` is expensive: prone to request waterfall and causes many DB queries.
- **Approach 2 (Store Direct-Use)**: Each diagram stores the diagrams it directly uses. On read, the backend performs a recursive SQL query to resolve transitive uses.
  - `UPDATE-DIRECT` is cheap: a single field update.
  - `READ` hits the DB once and makes 1 API call, but the recursive SQL query cost needs more verification (may be expensive).
- **Approach 3 (Store Transitive-Use)**: Each diagram stores all diagrams it transitively uses. On read, the backend returns the field directly.
  - `UPDATE-DIRECT` is expensive: must find all diagrams that transitively use the current one and recompute their transitive sets from scratch.
  - `READ` is cheap: a single field lookup.

### A Generalized Problem Statement

We can generalize our problem as follows:

- The diagram import graph is a directed graph where nodes are diagrams and edges are direct-use relations.
- Fetching all transitively used diagrams in one query is exactly computing the **transitive closure** of a node.

This is a well-known problem in graph theory and database research.

::: details What is Transitive Closure?
Given a directed graph $G = (V, E)$, the transitive closure $G^* = (V, E^*)$ is defined as:

$$E^* = \{ (u, v) \mid \exists \text{ a path from } u \text{ to } v \text{ in } G \}$$

Equivalently, $E^*$ is the least solution to:

$$X = E \cup (X \bowtie E)$$

where $R_1 \bowtie R_2 = \{ (u, w) \mid \exists v : (u, v) \in R_1 \land (v, w) \in R_2 \}$ is relational composition. Starting from $X = E$ and repeatedly applying $X := E \cup (X \bowtie E)$ until $X$ no longer grows yields $E^*$.

$TC(v)$ denotes the set of nodes reachable from $v$: $TC(v) = \{ u \mid (v, u) \in E^* \}$.
:::

::: note
Given a directed graph $G = (V, E)$, design a persistent data structure (or DB schema) that maintains $G$ under the following operations:

- `ADD` $[v]$: Add node $v$ to the graph with no edges. Formally: $V := V \cup \{v\}$.
- `UPDATE-DIRECT` $[v]$ $[N]$: Replace the out-neighborhood of $v$. Formally: $E := (E \setminus \{ (v, u) \mid u \in V \}) \cup \{ (v, u) \mid u \in N \}$.
- `READ` $[v]$: Return $TC(v)$.
- `DELETE` $[v]$: Remove $v$ and all incident edges. Formally: $V := V \setminus \{v\}$, $E := E \setminus \{ (v, u) \mid u \in V \} \setminus \{ (u, v) \mid u \in V \}$.

All operations must be efficient. Initially, $V = \emptyset$ and $E = \emptyset$.
:::

> Approach 2 and 3 are two ends of a classic tradeoff: compute on read vs. precompute on write. There is no known general solution that makes both `READ` and `UPDATE-DIRECT` O(1). Real solutions pick a point on this spectrum based on read/write ratio.

However, we allow `READ` to returns somewhat inaccurate results, such as forgetting to return some nodes (which can be fetched separately when discovered) or returning some redundant nodes (which can be ignored).

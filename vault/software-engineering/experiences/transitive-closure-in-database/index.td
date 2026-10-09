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

---
_type: Experience
_label: "Storing, Querying and Updating Transitive Closures in Database"
status: "active"
---

As stated in ${fref("software-engineering/experiences/file-system-on-the-web/index.td")}, we're building multifile support into dbdiagram. That experience mainly revolves around the large problem as a whole.

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

---
_type: SoftEngFlashcard
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/operational-transformation.td")
  - fref("software-engineering/concepts/crdt.td")
  - fref("software-engineering/concepts/last-writer-wins-register.td")
  - fref("software-engineering/concepts/optimistic-concurrency-control.td")
  - fref("software-engineering/concepts/fractional-indexing.td")
  - fref("software-engineering/concepts/long-polling.td")
---

::: flashcard
What is the difference between OT and CRDT?
=== OT transforms operations against each other on a central server (designed for text editing). CRDTs are data structures that converge automatically without a central authority (designed for decentralized systems). OT is harder to implement but has lower overhead. CRDTs have mathematical guarantees but carry overhead for tracking causality.
:::

::: flashcard
Why did Figma reject OT?
=== OT is designed for text editing and is extremely hard to implement correctly (combinatorial explosion of states). Figma is a design tool, not a text editor, so the complexity was not worth the power.
:::

::: flashcard
Why did Figma reject pure CRDTs?
=== CRDTs are designed for decentralized systems with no central authority, causing unavoidable performance and memory overhead. Figma is centralized (the server is the authority), so they can drop this overhead. They used CRDTs as inspiration instead.
:::

::: flashcard
What is a last-writer-wins register?
=== A CRDT that holds a single value. On conflict, the most recent write wins (using timestamp + peer ID to break ties). In a client-server setup, the server defines ordering so timestamps are not needed.
:::

::: flashcard
How does optimistic concurrency control work?
=== No lock is held between read and write. The client reads a version token (ETag, SHA, version number), modifies locally, then writes back with the token. The server rejects the write if the token changed (409 Conflict / 412 Precondition Failed). Same as Compare-and-Swap (CAS) at the application level.
:::

::: flashcard
How does optimistic concurrency differ from pessimistic locking?
=== Optimistic: No lock held. Conflicts detected at write time. Higher concurrency but clients must handle rejections. Pessimistic: Lock acquired before reading, held during edits, released after writing. Prevents conflicts but reduces concurrency and risks deadlocks.
:::

::: flashcard
What is fractional indexing?
=== A technique for ordering items in distributed systems. Each item's position is a fraction between 0 and 1. To insert between two items, set position to the average of theirs. No other items need updating (no reindexing).
:::

::: flashcard
What is long polling and how does it differ from polling and WebSockets?
=== Polling: Client periodically asks for updates (mostly empty responses, wastes bandwidth). Long polling: Server holds the connection open until it has data to send (efficient but holds one connection per client). WebSockets: Persistent bidirectional connection (lowest per-message overhead, most complex to implement).
:::

::: flashcard
What is the ETag + If-Match pattern in HTTP?
=== GET returns an ETag header (opaque version token). On PUT/DELETE, client sends `If-Match: "<etag>"`. Server rejects with 412 Precondition Failed if the ETag changed. This is optimistic concurrency control built into HTTP.
:::

::: flashcard
Who generates ETags: The HTTP server or the application?
=== For static files (JS, CSS, images), the HTTP server (Nginx, Apache) generates ETags automatically from file modification time + size. For dynamic resources (DB-backed content served via API), the application must generate and validate ETags itself.
:::

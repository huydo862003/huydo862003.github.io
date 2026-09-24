---
_type: SoftEngConcept
_label: 'Last-Writer-Wins Register'
journey: fref("software-engineering/index.td")
status: 'learning'
depends_on:
  - fref("software-engineering/concepts/crdt.td")
tags:
  - 'collaboration'
---

A CRDT that holds a single value. On conflict, the most recent write wins.

## How It Works

- Each update carries a value, a timestamp, and a peer ID.
- The register's value is determined by the latest update.
- Peer ID breaks ties when timestamps are equal.
- In a client-server setup, the server defines ordering, so timestamps are not needed (as in Figma and GitHub Contents API).

## Where It Appears

- Figma: Each (ObjectID, Property) pair is a last-writer-wins register. The server defines the order.
- GitHub Contents API: The `sha` field acts as a version check, but the underlying model is last-writer-wins on the whole file.
- ETags in REST APIs: The server's current ETag is the "latest value."

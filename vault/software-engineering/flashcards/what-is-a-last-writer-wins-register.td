---
_type: SoftEngFlashcard
_label: 'What is a last-writer-wins register?'
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/last-writer-wins-register.td")
---

::: flashcard
What is a last-writer-wins register?
=== key
A CRDT that holds a single value. On conflict, the most recent write wins (using timestamp + peer ID to break ties). In a client-server setup, the server defines ordering so timestamps are not needed.
:::

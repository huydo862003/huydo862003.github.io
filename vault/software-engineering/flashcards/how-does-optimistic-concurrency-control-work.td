---
_type: SoftEngFlashcard
_label: 'How does optimistic concurrency control work?'
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/optimistic-concurrency-control.td")
---

::: flashcard
How does optimistic concurrency control work?
=== key
No lock is held between read and write. The client reads a version token (ETag, SHA, version number), modifies locally, then writes back with the token. The server rejects the write if the token changed (409 Conflict / 412 Precondition Failed). Same as Compare-and-Swap (CAS) at the application level.
:::

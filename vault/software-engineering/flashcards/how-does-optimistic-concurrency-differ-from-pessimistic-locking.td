---
_type: SoftEngFlashcard
_label: 'How does optimistic concurrency differ from pessimistic locking?'
deck: 'collaboration'
tags:
  - 'collaboration'
concepts:
  - fref("software-engineering/concepts/optimistic-concurrency-control.td")
---

::: flashcard
How does optimistic concurrency differ from pessimistic locking?
=== key
Optimistic: No lock held. Conflicts detected at write time. Higher concurrency but clients must handle rejections. Pessimistic: Lock acquired before reading, held during edits, released after writing. Prevents conflicts but reduces concurrency and risks deadlocks.
:::

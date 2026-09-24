---
_type: SoftEngFlashcard
_label: 'What is fractional indexing?'
deck: 'collaboration'
tags:
  - 'collaboration'
concepts:
  - fref("software-engineering/concepts/fractional-indexing.td")
---

::: flashcard
What is fractional indexing?
=== key
A technique for ordering items in distributed systems. Each item's position is a fraction between 0 and 1. To insert between two items, set position to the average of theirs. No other items need updating (no reindexing).
:::

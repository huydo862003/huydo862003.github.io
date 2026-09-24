---
_type: SoftEngFlashcard
_label: 'What is the difference between OT and CRDT?'
deck: 'collaboration'
tags:
  - 'collaboration'
concepts:
  - fref("software-engineering/concepts/operational-transformation.td")
  - fref("software-engineering/concepts/crdt.td")
---

::: flashcard
What is the difference between OT and CRDT?
=== key
OT transforms operations against each other on a central server (designed for text editing). CRDTs are data structures that converge automatically without a central authority (designed for decentralized systems). OT is harder to implement but has lower overhead. CRDTs have mathematical guarantees but carry overhead for tracking causality.
:::

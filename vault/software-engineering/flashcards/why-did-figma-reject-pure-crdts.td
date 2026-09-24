---
_type: SoftEngFlashcard
_label: 'Why did Figma reject pure CRDTs?'
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/crdt.td")
---

::: flashcard
Why did Figma reject pure CRDTs?
=== key
CRDTs are designed for decentralized systems with no central authority, causing unavoidable performance and memory overhead. Figma is centralized (the server is the authority), so they can drop this overhead. They used CRDTs as inspiration instead.
:::

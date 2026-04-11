---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What's the difference between reflexivity and simpl in Rocq?
answer: TODO
deck: rocq-programming-language
concepts:
  - proof-by-simplification
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
keywords:
  - "proof by simplification"
  - "reflexivity"
  - "simpl"
  - "unfolds"
  - "terms"
  - "performs"
  - "simplification"
---


`reflexivity` performs more simplification than `simpl`.

- `simpl` lazily unfolds the terms and does not finish the proof.
- `reflexivity` eagerly unfolds the terms then finishes the proof.

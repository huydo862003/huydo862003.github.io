---
_type: Flashcard
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/proof-by-simplification.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
What's the difference between reflexivity and simpl in rocq?
=== key
`reflexivity` performs more simplification than `simpl`.

- `simpl` lazily unfolds the terms and does not finish the proof.
- `reflexivity` eagerly unfolds the terms then finishes the proof.
:::

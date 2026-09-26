---
_type: PltFlashcard
_label: 'What''s the difference between reflexivity and simpl in rocq?'
deck: 'rocq-programming-language'
concepts:
  - fref("programming-language-theory/concepts/proof-by-simplification.td")
books:
  - fref("programming-language-theory/books/software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
What's the difference between reflexivity and simpl in rocq?
=== key
`reflexivity` performs more simplification than `simpl`.

- `simpl` lazily unfolds the terms and does not finish the proof.
- `reflexivity` eagerly unfolds the terms then finishes the proof.
:::

---
_type: Flashcard
deck: 'type-theory'
concepts:
  - fref("journeys/programming-language-theory/concepts/hindley-milner-system.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
What is the Hindley-Milner type inference algorithm?
=== key
This algorithm works by:

1. Generate all constraints that the type variables must satisfy.
2. Solve those constraints (unification) to yield a type assignment.
:::

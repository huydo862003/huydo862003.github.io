---
_type: PltFlashcard
_label: 'What is the Hindley-Milner type inference algorithm?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/hindley-milner-system.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'type theory'
---

::: flashcard{deck="10-Type Theory"}
What is the Hindley-Milner type inference algorithm?
=== key
This algorithm works by:

1. Generate all constraints that the type variables must satisfy.
2. Solve those constraints (unification) to yield a type assignment.
:::

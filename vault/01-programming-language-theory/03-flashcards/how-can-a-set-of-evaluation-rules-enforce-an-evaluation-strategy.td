---
_type: PltFlashcard
_label: 'How can a set of evaluation rules enforce an evaluation strategy?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/evaluation-strategy.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/01-chapter-3-untyped-arithmetic-expressions.td")
tags:
  - 'language theory'
  - 'pure lambda calculus'
---

::: flashcard{deck="language theory"}
How can a set of evaluation rules enforce an evaluation strategy?
=== key
A set of evaluation rules can determine, for example, if arguments are evaluated before the enclosing redex, essentially determining if the evaluation strategy is lazy or eager.
:::

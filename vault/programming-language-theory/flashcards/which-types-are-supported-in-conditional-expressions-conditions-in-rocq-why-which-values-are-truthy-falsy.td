---
_type: PltFlashcard
_label: "Which types are supported in conditional expressions' conditions in Rocq? Why? W"
deck: 'rocq programming language'
concepts:
  - fref("/programming-language-theory/concepts/conditional-expression.td")
books:
  - fref("/programming-language-theory/books/software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq.td")
tags:
  - 'rocq programming language'
---

::: flashcard
Which types are supported in conditional expressions' conditions in rocq? why? which values are truthy/falsy?
=== key
- Inductive types with two constructors.
- Why: Rocq does not have a built-in boolean.
- The first constructor is truthy, the second is falsy.
:::

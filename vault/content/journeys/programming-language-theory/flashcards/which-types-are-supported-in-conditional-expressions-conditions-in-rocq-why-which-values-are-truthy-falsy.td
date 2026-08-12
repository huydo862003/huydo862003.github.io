---
_type: Flashcard
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/conditional-expression.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
Which types are supported in conditional expressions' conditions in rocq? why? which values are truthy/falsy?
=== key
- Inductive types with two constructors.
- Why: Rocq does not have a built-in boolean.
- The first constructor is truthy, the second is falsy.
:::

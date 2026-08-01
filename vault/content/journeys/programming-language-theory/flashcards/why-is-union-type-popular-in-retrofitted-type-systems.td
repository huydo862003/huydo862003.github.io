---
_type: Flashcard
question: "Why is union type popular in retrofitted type systems?"
deck: 'compiler-implementation'
concepts:
  - fref("journeys/programming-language-theory/concepts/retrofitted-type-system.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
${question}
=== key
In previously untyped languages, code can return values of multiple types, for example, valid results & errors.

-> This must be typable in the retrofitted type system.

-> Either union types or sum types. However, sum types require modifying the logic of existing code, rather than the more trivial type annotation additions.
:::

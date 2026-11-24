---
_type: PltFlashcard
_label: 'Why is union type popular in retrofitted type systems?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/retrofitted-type-system.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Compiler Implementation"}
Why is union type popular in retrofitted type systems?
=== key
In previously untyped languages, code can return values of multiple types, for example, valid results & errors.

-> This must be typable in the retrofitted type system.

-> Either union types or sum types. However, sum types require modifying the logic of existing code, rather than the more trivial type annotation additions.
:::

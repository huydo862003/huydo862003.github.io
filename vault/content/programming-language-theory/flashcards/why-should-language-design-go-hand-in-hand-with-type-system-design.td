---
_type: Flashcard
_label: 'Why should language design go hand in hand with type system design?'
deck: 'type-theory'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
---

::: flashcard
Why should language design go hand in hand with type system design?
=== key
According to Robert (Bob) Harper, type system is the central organizing principle in programming language theory.

- Language features: Manifestations of type structures.
- Syntax: Governed by type-defining constructs.
- Semantics: Emerged by their interactions.

According to Shriram Krishnamurthi, retrofitting type system into an untyped language can meet several challenges:

- Untyped language can encourage patterns or constructs that are hard to be soundly typed.
- Impossible to be given a precise type: `eval`.
:::

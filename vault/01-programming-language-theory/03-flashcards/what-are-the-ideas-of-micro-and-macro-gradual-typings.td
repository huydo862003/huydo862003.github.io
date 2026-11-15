---
_type: PltFlashcard
_label: 'What are the ideas of micro and macro gradual typings?'
deck: 'type theory'
concepts:
  - fref("/01-programming-language-theory/02-concepts/gradual-typing.td")
  - fref("/01-programming-language-theory/02-concepts/macro-gradual-typing.td")
  - fref("/01-programming-language-theory/02-concepts/micro-gradual-typing.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'type theory'
---

::: flashcard
What are the ideas of micro and macro gradual typings?
=== key
Gradual typing is often the formal term for retrofitted type systems.

- Micro gradual typing: The typed and untyped languages coexist within the same program, requiring a type to represent "untyped values".
- Macro gradual typing: The typed and untyped languages live separately but communicate via a contract. Contract violation and blame tracking are usually provided.
:::

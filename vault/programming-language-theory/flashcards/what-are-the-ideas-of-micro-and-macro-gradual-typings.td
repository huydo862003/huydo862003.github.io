---
_type: PltFlashcard
_label: 'What are the ideas of micro and macro gradual typings?'
deck: 'type theory'
concepts:
  - fref("programming-language-theory/concepts/gradual-typing.td")
  - fref("programming-language-theory/concepts/macro-gradual-typing.td")
  - fref("programming-language-theory/concepts/micro-gradual-typing.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
What are the ideas of micro and macro gradual typings?
=== key
Gradual typing is often the formal term for retrofitted type systems.

- Micro gradual typing: The typed and untyped languages coexist within the same program, requiring a type to represent "untyped values".
- Macro gradual typing: The typed and untyped languages live separately but communicate via a contract. Contract violation and blame tracking are usually provided.
:::

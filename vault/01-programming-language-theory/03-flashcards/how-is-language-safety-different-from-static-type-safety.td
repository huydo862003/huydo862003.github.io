---
_type: PltFlashcard
_label: 'How is language safety different from static type safety'
concepts:
  - fref("/01-programming-language-theory/02-concepts/language-safety.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/01-chapter-1-introduction.td")
tags:
  - 'type theory'
---

::: flashcard{deck="type theory"}
How is language safety different from static type safety
=== key
Static type safety means that if a compiler suggests that a program is free of any runtime type errors, running that program can never produce such an error.

Language safety means that an erroneous program can never corrupt the system.

Language safety = Static type check + Dynamic check.
:::

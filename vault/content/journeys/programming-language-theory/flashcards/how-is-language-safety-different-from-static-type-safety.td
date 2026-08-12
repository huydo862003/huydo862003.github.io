---
_type: Flashcard
question: 'How is language safety different from static type safety'
deck: 'type-theory'
concepts:
  - fref("journeys/programming-language-theory/concepts/language-safety.td")
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
---

::: flashcard
${question}
=== key
Static type safety means that if a compiler suggests that a program is free of any runtime type errors, running that program can never produce such an error.

Language safety means that an erroneous program can never corrupt the system.

Language safety = Static type check + Dynamic check.
:::

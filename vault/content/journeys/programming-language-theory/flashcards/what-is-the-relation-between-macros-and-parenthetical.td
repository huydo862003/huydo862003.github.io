---
_type: Flashcard
question: "What is the relation between macros and parenthetical language?"
deck: 'compiler-implementation'
concepts:
  - fref("journeys/programming-language-theory/concepts/macro.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
---

::: flashcard
${question}
=== key
It's easier to implement macro systems in parenthetical languages, as syntax and lists have the same structure. Therefore, a macro is literally a function that takes a list and yields another list.
:::

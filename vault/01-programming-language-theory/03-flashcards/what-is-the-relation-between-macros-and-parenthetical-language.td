---
_type: PltFlashcard
_label: 'What is the relation between macros and parenthetical language?'
deck: 'compiler implementation'
concepts:
  - fref("/01-programming-language-theory/02-concepts/macro.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/03-chapter-3-syntactic-sugar.td")
tags:
  - 'compiler implementation'
  - 'language philosophy'
  - 'language theory'
---

::: flashcard
What is the relation between macros and parenthetical language?
=== key
It's easier to implement macro systems in parenthetical languages, as syntax and lists have the same structure. Therefore, a macro is literally a function that takes a list and yields another list.
:::

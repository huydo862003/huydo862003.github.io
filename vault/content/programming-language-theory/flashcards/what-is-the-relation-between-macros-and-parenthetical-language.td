---
_type: Flashcard
deck: 'compiler-implementation'
concepts:
  - fref("programming-language-theory/concepts/macro.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
---

::: flashcard
What is the relation between macros and parenthetical language?
=== key
It's easier to implement macro systems in parenthetical languages, as syntax and lists have the same structure. Therefore, a macro is literally a function that takes a list and yields another list.
:::

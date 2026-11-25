---
_type: PltFlashcard
_label: 'According to computability theory, why do we split type checkers from parsers?'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="13-Compiler Implementation"}
According to computability theory, why do we split type checkers from parsers?
=== key
- Parser: Easy context-free grammar handling. Efficient & Decidable algorithms exist.

- Type checker: Context-sensitive. Can be inefficient or decidable.
:::

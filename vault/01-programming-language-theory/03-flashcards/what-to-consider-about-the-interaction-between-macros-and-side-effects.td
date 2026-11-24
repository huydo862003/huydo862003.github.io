---
_type: PltFlashcard
_label: 'What to consider about the interaction between macros and side effects?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/macro.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/03-chapter-3-syntactic-sugar.td")
tags:
  - 'programming language basic'
  - 'language theory'
---

::: flashcard{deck="Programming Language Basics"}
What to consider about the interaction between macros and side effects?
=== key
An argument to the macro can be substituted multiple times into the macro's body, causing the argument to be evaluated multiple times. If the argument evaluation has side effects, it can be confusing.
:::

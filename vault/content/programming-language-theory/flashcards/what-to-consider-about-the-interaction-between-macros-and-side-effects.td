---
_type: Flashcard
deck: 'programming-language-basic'
concepts:
  - fref("programming-language-theory/concepts/macro.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
---

::: flashcard
What to consider about the interaction between macros and side effects?
=== key
An argument to the macro can be substituted multiple times into the macro's body, causing the argument to be evaluated multiple times. If the argument evaluation has side effects, it can be confusing.
:::

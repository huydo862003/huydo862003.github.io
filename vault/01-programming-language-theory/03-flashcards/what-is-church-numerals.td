---
_type: PltFlashcard
_label: 'What is church numerals?'
deck: 'pure lambda calculus'
concepts:
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
  - fref("/01-programming-language-theory/02-concepts/church-numeral.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard
What is church numerals?
=== key
Church numerals is an encoding of natural numbers in Pure/Untyped lambda calculus.

$$
c_n = \lambda a.\ \lambda z.\ a\ (a\ (...\ z)\ ...)
$$
:::

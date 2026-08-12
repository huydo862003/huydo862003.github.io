---
_type: Flashcard
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
  - fref("programming-language-theory/concepts/church-numeral.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What is church numerals?
=== key
Church numerals is an encoding of natural numbers in Pure/Untyped lambda calculus.

$$
c_n = \lambda a.\ \lambda z.\ a\ (a\ (...\ z)\ ...)
$$
:::

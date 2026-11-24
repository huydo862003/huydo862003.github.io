---
_type: PltFlashcard
_label: "What's special about 0 and fls in church encoding?"
concepts:
  - fref("/01-programming-language-theory/02-concepts/church-numeral.td")
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard{deck="Pure Lambda Calculus"}
What's special about 0 and fls in church encoding?
=== key
- 0 in Church numerals: $\lambda a.\ \lambda z.\ z$.
- false in Church booleans: $\lambda f.\ \lambda s.\ s$.

-> Identical.
:::

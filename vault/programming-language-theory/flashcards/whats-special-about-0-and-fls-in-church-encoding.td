---
_type: PltFlashcard
_label: 'What''s special about 0 and fls in church encoding?'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/church-numeral.td")
  - fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What's special about 0 and fls in church encoding?
=== key
- 0 in Church numerals: $\lambda a.\ \lambda z.\ z$.
- false in Church booleans: $\lambda f.\ \lambda s.\ s$.

-> Identical.
:::

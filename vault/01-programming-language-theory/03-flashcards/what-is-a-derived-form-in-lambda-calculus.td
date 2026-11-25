---
_type: PltFlashcard
_label: 'What is a derived form in lambda calculus?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/derived-form.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="12-Pure Lambda Calculus"}
What is a derived form in lambda calculus?
=== key
A construct that adds no expressive power but can be translated into more primitive forms, e.g., $\text{let}\ x = s\ \text{in}\  t$ desugars to $(\lambda x.\ t)\ s$.
:::

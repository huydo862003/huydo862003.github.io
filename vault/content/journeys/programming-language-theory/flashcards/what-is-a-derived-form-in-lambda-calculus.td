---
_type: Flashcard
question: "What is a derived form in lambda calculus?"
deck: 'pure-lambda-calculus'
concepts:
  - fref("journeys/programming-language-theory/concepts/derived-form.td")
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
${question}
=== key
A construct that adds no expressive power but can be translated into more primitive forms, e.g., $\text{let}\ x = s\ \text{in}\  t$ desugars to $(\lambda x.\ t)\ s$.
:::

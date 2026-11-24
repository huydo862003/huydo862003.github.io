---
_type: PltFlashcard
_label: 'How to encode booleans and conditionals using church booleans in lambda calculus?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="pure lambda calculus"}
How to encode booleans and conditionals using church booleans in lambda calculus?
=== key
Booleans:

$$
\begin{aligned}
\text{tru} & = \lambda f.\ \lambda s.\ f \\
\text{fls} & = \lambda f.\ \lambda s.\ s \\
\end{aligned}
$$

Conditionals (call-by-name):

$$
\text{test} = \lambda c.\ \lambda t.\ \lambda e.\ c\ t\ e
$$
:::

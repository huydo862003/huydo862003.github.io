---
_type: Flashcard
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
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

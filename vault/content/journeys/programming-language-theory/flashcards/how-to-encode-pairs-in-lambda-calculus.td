---
_type: Flashcard
deck: 'pure-lambda-calculus'
concepts:
  - fref("journeys/programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
How to encode pairs in lambda calculus?
=== key
$$
\begin{aligned}
\text{pair} & = \lambda f.\ \lambda s. \ \lambda o.\ o\ f\ s \\
\text{fst} & = \lambda p.\ p\ \text{tru} \\
\text{snd} & = \lambda p.\ p\ \text{fls}
\end{aligned}
$$
:::

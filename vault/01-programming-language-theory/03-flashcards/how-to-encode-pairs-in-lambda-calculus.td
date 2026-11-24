---
_type: PltFlashcard
_label: 'How to encode pairs in lambda calculus?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="pure lambda calculus"}
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

---
_type: PltFlashcard
_label: 'Define boolean operations and, or, not for church booleans?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="12-Pure Lambda Calculus"}
Define boolean operations and, or, not for church booleans?
=== key
Church booleans:

$$
\begin{aligned}
\text{tru} & = \lambda f.\ \lambda s.\ f \\
\text{fls} & = \lambda f.\ \lambda s.\ s
\end{aligned}
$$

- And:

    $\text{and} = \lambda b_1.\ \lambda b_2.\ b_1\ b_2\ \text{fls}$

- Or:

    $\text{or} = \lambda b_1.\ \lambda b_2.\ b_1\ \text{tru}\ b_2$

- Not:

    $\text{not} = \lambda b.\ b\ \text{fls}\ \text{tru}$
:::

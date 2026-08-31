---
_type: PltFlashcard
_label: 'Define boolean operations and, or, not for church booleans?'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
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

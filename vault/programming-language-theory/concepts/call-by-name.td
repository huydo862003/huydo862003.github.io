---
_type: PltConcept
_label: 'Call by name'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'language feature design'
  - 'semantics'
---

::: info
(Lambda calculus, Semantics) An evaluation strategy that is ${fref("programming-language-theory/concepts/normal-order.td")} but ${fref("programming-language-theory/concepts/beta-reduction.td")} inside ${fref("programming-language-theory/concepts/lambda-abstraction.td")} is not allowed.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

---
_type: PltConcept
_label: 'Call by value'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'semantics'
---

::: info
(Lambda calculus, Semantics) A ${fref("/01-programming-language-theory/02-concepts/strict-eager-evaluation-strategy.td")} in which ${fref("/01-programming-language-theory/02-concepts/beta-redex-reducible-expression.td")}s inside lambda abstractions must not be reduced.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{v_1\ t_2 \to v_1\ t_2'}$
- $(\lambda x.\ t)\ v \to [x \to v] t$

---
_type: PltConcept
_label: 'Call by value'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Lambda calculus, Semantics) A ${fref("/programming-language-theory/concepts/strict-eager-evaluation-strategy.td")} in which ${fref("/programming-language-theory/concepts/beta-redex-reducible-expression.td")}s inside lambda abstractions must not be reduced.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{v_1\ t_2 \to v_1\ t_2'}$
- $(\lambda x.\ t)\ v \to [x \to v] t$

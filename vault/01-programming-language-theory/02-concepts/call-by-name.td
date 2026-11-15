---
_type: PltConcept
_label: 'Call by name'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Lambda calculus, Semantics) An evaluation strategy that is ${fref("/01-programming-language-theory/02-concepts/normal-order.td")} but ${fref("/01-programming-language-theory/02-concepts/beta-reduction.td")} inside ${fref("/01-programming-language-theory/02-concepts/lambda-abstraction.td")} is not allowed.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

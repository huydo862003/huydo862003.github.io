---
_type: PltConcept
_label: 'Full beta-reduction'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'semantics'
tags:
  - 'semantics'
---

In ${fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")}, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'}$
- $\displaystyle \frac{t_2 \to t_2'}{\lambda x.\ t_2 \to \lambda x.\ t_2' }$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

---
_type: Concept
_label: 'Full beta-reduction'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'semantics'
---

In ${fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")}, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'}$
- $\displaystyle \frac{t_2 \to t_2'}{\lambda x.\ t_2 \to \lambda x.\ t_2' }$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

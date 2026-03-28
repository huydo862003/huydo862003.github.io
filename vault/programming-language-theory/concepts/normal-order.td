---
_type: Concept
_label: 'Normal order'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'semantics'
---

In pure lambda calculus, this strategy is defined by the following rules:

- $(\lambda x.\ t_1)\ t_2 \to [x \mapsto t_2]\, t_1$
- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \quad (t_1 \text{ is not a } \lambda)$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'} \quad (t_1 \text{ in normal form})$
- $\displaystyle \frac{t \to t'}{\lambda x.\ t \to \lambda x.\ t'}$

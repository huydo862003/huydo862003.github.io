---
_type: PltConcept
_label: 'Normal order'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

In pure lambda calculus, this strategy is defined by the following rules:

- $(\lambda x.\ t_1)\ t_2 \to [x \mapsto t_2]\, t_1$
- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \quad (t_1 \text{ is not a } \lambda)$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'} \quad (t_1 \text{ in normal form})$
- $\displaystyle \frac{t \to t'}{\lambda x.\ t \to \lambda x.\ t'}$

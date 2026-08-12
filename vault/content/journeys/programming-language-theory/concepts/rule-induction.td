---
_type: Concept
title: 'Rule induction'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
---

$$
\displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{a\ J}
$$

we typically need to show:

$$
\displaystyle\frac{\mathcal{P}(a_1)\ \dots\ \mathcal{P}(a_k)}{\mathcal{P}(a)}
$$

Then, we can conclude that whenever $a\ J$, $\mathcal{P}(a)$

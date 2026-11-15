---
_type: PltConcept
_label: 'Rule induction'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

$$
\displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{a\ J}
$$

we typically need to show:

$$
\displaystyle\frac{\mathcal{P}(a_1)\ \dots\ \mathcal{P}(a_k)}{\mathcal{P}(a)}
$$

Then, we can conclude that whenever $a\ J$, $\mathcal{P}(a)$

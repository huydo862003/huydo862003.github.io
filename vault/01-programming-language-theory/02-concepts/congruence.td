---
_type: PltConcept
_label: 'Congruence'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/01-programming-language-theory/02-concepts/equivalence.td")} relation that is preserved under a specific operation. That is, assume a congruence $\mathcal{C}$ and an operation $p$, we have $a\ \mathcal{C}\ b \iff p(a)\ \mathcal{C}\ p(b)$.

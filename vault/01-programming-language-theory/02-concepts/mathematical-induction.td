---
_type: PltConcept
_label: 'Mathematical induction'
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

Formally, assume $n\ \text{nat}$ means that $n$ is a natural number. To prove that whenever $n\ \text{nat}$, we have $\mathcal{P}(n)$, it's sufficient to show that:

1. $\mathcal{P}(\text{zero})$.
2. For every $n$ such that $n\ \text{nat}$, if $\mathcal{P}(n)$ then $\mathcal{P}(\text{succ}(n))$.

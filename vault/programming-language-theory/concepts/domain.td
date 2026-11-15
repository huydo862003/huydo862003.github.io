---
_type: PltConcept
_label: 'Domain'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'order & lattice theory'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Set theory & Relation, Order & Lattice theory) A mathematical structure (typically a **complete Partial order** with a bottom element) used in ${fref("/programming-language-theory/concepts/denotational-semantics.td")} to model computation - enables reasoning about recursion, non-termination, and fixed points; values form a lattice where $\bot$ represents divergence/undefined.
:::

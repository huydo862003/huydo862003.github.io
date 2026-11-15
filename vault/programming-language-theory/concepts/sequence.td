---
_type: PltConcept
_label: 'Sequence'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'order & lattice theory'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ordered collection of elements indexed by natural numbers - formally, a function from $\mathbb{N}$ to some set, denoted $(a_0, a_1, a_2, ...)$ or $(a_i)_i\in\mathbb{N}$.

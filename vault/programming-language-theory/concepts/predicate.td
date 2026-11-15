---
_type: PltConcept
_label: 'Predicate'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An unary n-place relation $P$, $(s) \in P$  is typically written as $P(s)$.

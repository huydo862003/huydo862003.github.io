---
_type: PltConcept
_label: 'Partial function'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/binary-relation.td")} $R$ such that if $s\ R\ t_1$ and $s\ R\ t_2$ then $t_1 = t_2$.

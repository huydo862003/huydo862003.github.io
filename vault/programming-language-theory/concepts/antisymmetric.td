---
_type: PltConcept
_label: 'Antisymmetric'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A property of a ${fref("/programming-language-theory/concepts/binary-relation.td")} $R$ such that if $t\ R\ s$ and $s\ R\ t$ then $s = t$, for every $t$, $s$ $\in T$.

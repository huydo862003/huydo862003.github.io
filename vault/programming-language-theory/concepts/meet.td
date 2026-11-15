---
_type: PltConcept
_label: 'Meet'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'order & lattice theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

In the context of a ${fref("/programming-language-theory/concepts/partial-order.td")}, the greatest lower bound of a set $S$, denoted as $\bigwedge S$ .

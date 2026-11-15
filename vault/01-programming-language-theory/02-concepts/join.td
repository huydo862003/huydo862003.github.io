---
_type: PltConcept
_label: 'Join'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'order & lattice theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

In the context of a ${fref("/01-programming-language-theory/02-concepts/partial-order.td")}, the least upper bound of a set $S$, denoted $\bigvee S$.

---
_type: PltConcept
_label: 'Well-founded'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'order & lattice theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of a ${fref("/programming-language-theory/concepts/preorder.td")} whose strict part ($a < b \iff a \le b\land b \not\le a$ ) admits no infinite descending chains, ensuring every non-empty subset has a minimal element.

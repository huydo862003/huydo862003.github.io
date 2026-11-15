---
_type: PltConcept
_label: 'Interpretation'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A semantic mapping that assigns meaning to a Representation (e.g., 0b101 can interpret as 5 in binary or a bit pattern).

A **semantic mapping** that assigns meaning to a ${fref("/programming-language-theory/concepts/representation.td")} (e.g., `0b101` can interpret as `5` in binary or a bit pattern).

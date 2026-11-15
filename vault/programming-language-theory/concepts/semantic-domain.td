---
_type: PltConcept
_label: 'Semantic domain'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The mathematical structure (e.g., sets, functions, lattices) in which terms are given meaning by a ${fref("/programming-language-theory/concepts/denotational-semantics.td")}.

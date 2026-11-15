---
_type: PltConcept
_label: 'Runtime monitoring'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'runtime'
tags:
  - 'formal system'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A dynamic verification technique that inserts observers to track program execution and detect when behavior deviates from specified properties (e.g., ${fref("/programming-language-theory/concepts/contract.td")}s, protocols, temporal constraints).

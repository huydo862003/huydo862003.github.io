---
_type: PltConcept
_label: 'Decreasing analysis'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'program analysis'
tags:
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

[Rocq] A **termination check** in Rocq that verifies recursive functions always call themselves on structurally smaller arguments, ensuring all computations terminate (required for logical consistency).

---
_type: PltConcept
_label: 'Value environment'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'runtime'
  - 'semantics'
tags:
  - 'runtime'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mapping from variable names to runtime values used during interpretation.

A mapping from variable names to **runtime values** used during interpretation.

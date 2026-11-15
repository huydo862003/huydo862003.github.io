---
_type: PltConcept
_label: 'Dimensional analysis'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'other mathematics'
  - 'program analysis'
  - 'type theory'
tags:
  - 'other mathematics'
  - 'program analysis'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A static verification technique that encodes domain-specific properties (e.g., physical units, array bounds, indices) into types, ensuring operations respect these invariants by detecting mismatches at compile time rather than runtime.

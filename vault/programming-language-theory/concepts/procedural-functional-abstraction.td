---
_type: PltConcept
_label: 'Procedural/Functional abstraction'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The principle of encapsulating a computation behind a named interface, hiding implementation details and allowing reuse by parameterizing over inputs.

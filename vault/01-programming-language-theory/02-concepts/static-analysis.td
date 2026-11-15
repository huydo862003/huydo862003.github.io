---
_type: PltConcept
_label: 'Static analysis'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Program analysis performed without executing the code, including type checking, dataflow analysis, and abstract interpretation. Can detect certain errors and properties before runtime.

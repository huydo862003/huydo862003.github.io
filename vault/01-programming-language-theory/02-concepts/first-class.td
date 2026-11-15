---
_type: PltConcept
_label: 'First-class'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

- Can be stored in variables.
- Passed as arguments.
- Returned from functions.
- Created at runtime.
- Embedded in data structures without restriction.

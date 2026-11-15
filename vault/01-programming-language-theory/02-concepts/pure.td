---
_type: PltConcept
_label: 'Pure'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'program analysis'
  - 'programming paradigm'
  - 'semantics'
tags:
  - 'design principle'
  - 'program analysis'
  - 'programming paradigm'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of a function or computation that has no side effects and always returns the same output for the same input, making it referentially transparent.

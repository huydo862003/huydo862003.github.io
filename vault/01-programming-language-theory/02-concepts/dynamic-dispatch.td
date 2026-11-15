---
_type: PltConcept
_label: 'Dynamic dispatch'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A runtime mechanism that selects which method implementation to invoke based on the actual dynamic properties of the object, rather than the declared static properties of the reference, enabling polymorphic behavior. Contrast with ${fref("/01-programming-language-theory/02-concepts/static-dispatch.td")}.

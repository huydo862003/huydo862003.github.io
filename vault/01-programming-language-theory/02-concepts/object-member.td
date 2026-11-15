---
_type: PltConcept
_label: 'Object member'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A component of an object, either a ${fref("/01-programming-language-theory/02-concepts/field.td")} (data) or a ${fref("/01-programming-language-theory/02-concepts/method.td")} (behavior).

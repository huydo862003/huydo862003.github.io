---
_type: PltConcept
_label: 'Static dispatch'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Method resolution that occurs at compile time based on some known (may be imprecise) static properties (such as types) of the receiver, as opposed to ${fref("/01-programming-language-theory/02-concepts/dynamic-dispatch.td")} which resolves at runtime based on the actual dynamic properties.

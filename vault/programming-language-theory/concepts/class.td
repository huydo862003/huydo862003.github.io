---
_type: PltConcept
_label: 'Class'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A blueprint or template that defines the structure (fields) and behavior (methods) for creating objects, serving as a factory for instantiating objects with shared characteristics.

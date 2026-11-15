---
_type: PltConcept
_label: 'Structural type'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type defined by its shape (fields, methods, signatures) rather than its name - two types are equal if they have the same structure.

A type defined by its **shape** (fields, methods, signatures) rather than its name - two types are equal if they have the same structure.

---
_type: PltConcept
_label: 'Nominal type'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type identified by its name - two types are equal only if they have the same declared name, regardless of structure.

A type identified by its **name** - two types are equal only if they have the same declared name, regardless of structure.

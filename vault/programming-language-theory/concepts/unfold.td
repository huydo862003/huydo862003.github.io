---
_type: PltConcept
_label: 'Unfold'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A reduction step that replaces a defined name with its definition body, expanding abbreviations to expose underlying structure.

A **reduction step** that replaces a defined name with its definition body, expanding abbreviations to expose underlying structure.

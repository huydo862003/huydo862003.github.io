---
_type: PltConcept
_label: 'Static member'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A field or method that belongs to the ${fref("/programming-language-theory/concepts/class.td")} itself rather than to instances, shared across all objects of that class and accessible without creating an instance.

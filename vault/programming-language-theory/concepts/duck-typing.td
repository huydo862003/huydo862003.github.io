---
_type: PltConcept
_label: 'Duck typing'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An informal term for Structural typing - if an object has the required methods/properties (\"quacks like a duck\"), it can be used regardless of its declared type or class hierarchy.

An informal term for ${fref("/programming-language-theory/concepts/structural-typing.td")} - if an object has the required methods/properties ("quacks like a duck"), it can be used regardless of its declared type or class hierarchy.

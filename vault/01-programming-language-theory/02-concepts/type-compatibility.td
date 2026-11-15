---
_type: PltConcept
_label: 'Type compatibility'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'set theory & relation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A relation between types that implies ${fref("/01-programming-language-theory/02-concepts/substitutability.td")}. A static approximation of Substitutability.

---
_type: PltConcept
_label: 'Type compatibility'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'set theory & relation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A relation between types that implies ${fref("/programming-language-theory/concepts/substitutability.td")}. A static approximation of Substitutability.

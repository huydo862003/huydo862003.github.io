---
_type: PltConcept
_label: 'Function header'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The declarative part of a function that specifies its name, ${fref("/01-programming-language-theory/02-concepts/formal-parameter.td")}s, and return type (if any), without the body implementation.

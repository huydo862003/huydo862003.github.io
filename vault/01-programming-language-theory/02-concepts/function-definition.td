---
_type: PltConcept
_label: 'Function definition'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic construct that declares a function by specifying its name (optionally), ${fref("/01-programming-language-theory/02-concepts/formal-parameter.td")}s, and body - establishing a binding between the name and the corresponding abstraction.

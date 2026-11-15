---
_type: PltConcept
_label: 'Runtime type information (RTTI)'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mechanism that allows the reflection of the type of a value at runtime.

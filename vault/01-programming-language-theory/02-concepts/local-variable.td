---
_type: PltConcept
_label: 'Local variable'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A variable declared within a ${fref("/01-programming-language-theory/02-concepts/block.td")} or function whose ${fref("/01-programming-language-theory/02-concepts/scope.td")} and ${fref("/01-programming-language-theory/02-concepts/lifetime.td")} are limited to that region - inaccessible from outside and typically deallocated when the block exits.

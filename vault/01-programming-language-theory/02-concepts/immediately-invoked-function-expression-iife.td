---
_type: PltConcept
_label: 'Immediately invoked function expression (IIFE)'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example: ${fref("/01-programming-language-theory/02-concepts/parallel-simultaneous-let.td")} in Scheme is actually a ${fref("/01-programming-language-theory/02-concepts/syntactic-sugar.td")} for IIFE.

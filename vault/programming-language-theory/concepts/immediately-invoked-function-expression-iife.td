---
_type: PltConcept
_label: 'Immediately invoked function expression (IIFE)'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example: ${fref("/programming-language-theory/concepts/parallel-simultaneous-let.td")} in Scheme is actually a ${fref("/programming-language-theory/concepts/syntactic-sugar.td")} for IIFE.

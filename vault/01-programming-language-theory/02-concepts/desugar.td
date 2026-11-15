---
_type: PltConcept
_label: 'Desugar'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The process of transforming ${fref("/01-programming-language-theory/02-concepts/syntactic-sugar.td")} or high-level constructs into more primitive forms in the ${fref("/01-programming-language-theory/02-concepts/core-calculus-language.td")}, simplifying the interpreter or compiler implementation.

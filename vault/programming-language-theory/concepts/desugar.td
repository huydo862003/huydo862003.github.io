---
_type: PltConcept
_label: 'Desugar'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The process of transforming ${fref("/programming-language-theory/concepts/syntactic-sugar.td")} or high-level constructs into more primitive forms in the ${fref("/programming-language-theory/concepts/core-calculus-language.td")}, simplifying the interpreter or compiler implementation.

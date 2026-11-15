---
_type: PltConcept
_label: 'Conditional expression'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An expression that selects between alternatives based on a boolean or ${fref("/programming-language-theory/concepts/pattern-matching.td")} (like if b then x else y or ternary b ? x : y).

An **expression** that selects between alternatives based on a boolean or pattern match (like `if b then x else y` or ternary `b ? x : y`).

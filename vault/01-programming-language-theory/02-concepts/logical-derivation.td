---
_type: PltConcept
_label: 'Logical derivation'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A step-by-step proof showing how a conclusion follows from premises using ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s - each step applies a rule to previous steps; in type systems, a ${fref("/01-programming-language-theory/02-concepts/derivation-tree.td")} is a derivation proving that an

A step-by-step **proof** showing how a conclusion follows from premises using Inference rules - each step applies a rule to previous steps; in type systems, a Judgment **tree** is a derivation proving that an expression has a certain type.

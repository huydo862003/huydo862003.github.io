---
_type: PltConcept
_label: 'Logical system'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A formal framework comprising a syntax (well-formed formulas), ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s, and ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s that together determine which statements are ${fref("/01-programming-language-theory/02-concepts/derivable.td")}.

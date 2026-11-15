---
_type: PltConcept
_label: 'Logical system'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A formal framework comprising a syntax (well-formed formulas), ${fref("/programming-language-theory/concepts/axiom.td")}s, and ${fref("/programming-language-theory/concepts/inference-rule.td")}s that together determine which statements are ${fref("/programming-language-theory/concepts/derivable.td")}.

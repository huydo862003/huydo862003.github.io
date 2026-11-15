---
_type: PltConcept
_label: 'Natural deduction style'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A presentation of ${fref("/01-programming-language-theory/02-concepts/logical-system.td")}s where ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s are organized into ${fref("/01-programming-language-theory/02-concepts/introduction-rule.td")} and ${fref("/01-programming-language-theory/02-concepts/elimination-rule.td")} for each connective, with proofs structured as trees that introduce and discharge assumptions.

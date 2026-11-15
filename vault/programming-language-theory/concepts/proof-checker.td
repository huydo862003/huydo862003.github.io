---
_type: PltConcept
_label: 'Proof checker'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A program that verifies whether a given proof is valid according to the rules of a ${fref("/programming-language-theory/concepts/formal-system.td")}, confirming that each step correctly follows from the ${fref("/programming-language-theory/concepts/axiom.td")}s and ${fref("/programming-language-theory/concepts/inference-rule.td")}s.

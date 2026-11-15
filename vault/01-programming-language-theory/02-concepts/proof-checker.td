---
_type: PltConcept
_label: 'Proof checker'
journey: fref("/01-programming-language-theory/index.td")
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

A program that verifies whether a given proof is valid according to the rules of a ${fref("/01-programming-language-theory/02-concepts/formal-system.td")}, confirming that each step correctly follows from the ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s and ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s.

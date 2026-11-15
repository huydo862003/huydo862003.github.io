---
_type: PltConcept
_label: 'Hoare logic'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
  - 'proof/reason technique'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A formal system for reasoning about program correctness using triples {P} C {Q} (precondition, command, postcondition) to specify and verify imperative programs.

A ${fref("/01-programming-language-theory/02-concepts/formal-system.td")} for reasoning about program correctness using triples `\{P\} C \{Q\}` (precondition, command, postcondition) to specify and verify imperative programs.

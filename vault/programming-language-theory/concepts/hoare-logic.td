---
_type: PltConcept
_label: 'Hoare logic'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
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

A ${fref("/programming-language-theory/concepts/formal-system.td")} for reasoning about program correctness using triples `\{P\} C \{Q\}` (precondition, command, postcondition) to specify and verify imperative programs.

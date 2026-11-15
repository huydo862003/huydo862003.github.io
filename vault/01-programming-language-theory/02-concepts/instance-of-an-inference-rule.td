---
_type: PltConcept
_label: 'Instance of an inference rule'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A specific substitution of the rule's ${fref("/01-programming-language-theory/02-concepts/metavariable.td")}s with concrete terms, yielding a particular ${fref("/01-programming-language-theory/02-concepts/derivation.td")} step.

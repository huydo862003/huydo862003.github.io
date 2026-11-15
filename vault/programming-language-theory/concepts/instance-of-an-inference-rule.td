---
_type: PltConcept
_label: 'Instance of an inference rule'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A specific substitution of the rule's ${fref("/programming-language-theory/concepts/metavariable.td")}s with concrete terms, yielding a particular ${fref("/programming-language-theory/concepts/derivation.td")} step.

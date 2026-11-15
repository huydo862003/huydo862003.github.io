---
_type: PltConcept
_label: 'Evaluation/Reduction relation'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An n-place relation on the set of terms in a calculus that represents computation, either ${fref("/programming-language-theory/concepts/small-step-structural-operational-semantics-sos.td")}, ${fref("/programming-language-theory/concepts/big-step-natural-operational-semantics.td")} or something else.

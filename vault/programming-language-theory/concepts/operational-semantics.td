---
_type: PltConcept
_label: 'Operational semantics'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A style of semantics that defines the meaning of programs by syntactically transforming terms according to reduction rules, specifying execution either step-by-step (${fref("/programming-language-theory/concepts/small-step-structural-operational-semantics-sos.td")}) or as a direct relation to final values (${fref("/programming-language-theory/concepts/big-step-natural-operational-semantics.td")}).

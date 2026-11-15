---
_type: PltConcept
_label: 'Small-step/Structural operational semantics (SOS)'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A style of semantics which defines evaluation via ${fref("/programming-language-theory/concepts/evaluation-statement-judgement.td")} of the form $t \to t'$, specifying how a term reduces by one atomic step at a time until reaching a ${fref("/programming-language-theory/concepts/normal-form.td")}.

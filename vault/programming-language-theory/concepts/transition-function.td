---
_type: PltConcept
_label: 'Transition function'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'semantics'
tags:
  - 'computation theory'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/partial-function.td")} from machine configurations (term, environment, stack, etc.) to successor configurations, defining each atomic step of execution until a final state is reached. In ${fref("/programming-language-theory/concepts/lambda-calculus.td")} with [Small-step/Structural operational semantics (SOS)](/plt/concepts/small-step-structural-operational-semantics-sos), the transition function usually relates a term with a simplification of that term, and is undefined for ${fref("/programming-language-theory/concepts/normal-form.td")}s.

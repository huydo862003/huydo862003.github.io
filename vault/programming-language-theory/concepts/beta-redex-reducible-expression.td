---
_type: PltConcept
_label: 'Beta-redex/Reducible expression'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A term of the form: $t_1\ t_2$, in which $t_1$ is a ${fref("/programming-language-theory/concepts/lambda-abstraction.td")} and $t_2$ is any term.

---
_type: PltConcept
_label: 'State'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'language feature/design'
  - 'program analysis'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The complete configuration of an ${fref("/programming-language-theory/concepts/abstract-machine.td")} at a point during evaluation, comprising the current term and any auxiliary data (e.g., ${fref("/programming-language-theory/concepts/environment.td")}, store, stack). In ${fref("/programming-language-theory/concepts/pure-untyped-lambda-calculus.td")}, the state is simply a ${fref("/programming-language-theory/concepts/lambda-term.td")}.

---
_type: PltConcept
_label: 'Combinator'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/lambda-term.td")} that contains no ${fref("/programming-language-theory/concepts/free-variable.td")}, or in other words, a ${fref("/programming-language-theory/concepts/closed-term.td")}.

---
_type: PltConcept
_label: 'Combinator'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/lambda-term.td")} that contains no ${fref("/01-programming-language-theory/02-concepts/free-variable.td")}, or in other words, a ${fref("/01-programming-language-theory/02-concepts/closed-term.td")}.

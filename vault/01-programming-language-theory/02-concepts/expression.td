---
_type: PltConcept
_label: 'Expression'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Semantics, Syntax & Grammar, Language feature/design) A syntactic construct that evaluates to a value, as opposed to a ${fref("/01-programming-language-theory/02-concepts/statement.td")}.
:::

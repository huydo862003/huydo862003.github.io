---
_type: PltConcept
_label: 'Small omega combinator'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/combinator.td")} defined as $\omega = \lambda x.\ x\ x$, useful in many patterns, such as ${fref("/01-programming-language-theory/02-concepts/extensible-open-recursion.td")}.

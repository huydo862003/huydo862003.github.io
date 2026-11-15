---
_type: PltConcept
_label: 'Lambda abstraction'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/lambda-term.td")} of the form $\lambda x.\  t$ - a function that binds variable $x$ over body $t$.

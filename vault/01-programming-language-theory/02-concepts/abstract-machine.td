---
_type: PltConcept
_label: 'Abstract machine'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'computation theory'
  - 'linguistics'
  - 'runtime'
tags:
  - 'compiler implementation'
  - 'computation theory'
  - 'linguistics'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A formal model of computation defined by a set of states, an initial state, final states, and a ${fref("/01-programming-language-theory/02-concepts/transition-function.td")} specifying how states evolve step-by-step until halting.

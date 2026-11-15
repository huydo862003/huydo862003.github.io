---
_type: PltConcept
_label: 'SAT solver'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/decision-procedure.td")} that determines whether a propositional boolean formula has a satisfying assignment, foundational to many automated reasoning tools.

A **decision procedure** that determines whether a propositional boolean formula has a satisfying assignment, foundational to many automated reasoning tools.

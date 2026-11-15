---
_type: PltConcept
_label: 'Name combination algebra'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'other mathematics'
  - 'semantics'
  - 'type theory'
tags:
  - 'other mathematics'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The set of rules governing how names interact when combining program fragments, addressing whether bindings ${fref("/01-programming-language-theory/02-concepts/shadowing.td")}, conflict, or merge (central to understanding ${fref("/01-programming-language-theory/02-concepts/substitution.td")}, ${fref("/01-programming-language-theory/02-concepts/scope.td")}, and module composition).

The **set of rules** governing how names interact when combining program fragments, addressing whether bindings shadow, conflict, or merge (central to understanding substitution, scope, and module composition).

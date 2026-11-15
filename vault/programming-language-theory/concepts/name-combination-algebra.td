---
_type: PltConcept
_label: 'Name combination algebra'
journey: fref("/programming-language-theory/index.td")
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

The set of rules governing how names interact when combining program fragments, addressing whether bindings ${fref("/programming-language-theory/concepts/shadowing.td")}, conflict, or merge (central to understanding ${fref("/programming-language-theory/concepts/substitution.td")}, ${fref("/programming-language-theory/concepts/scope.td")}, and module composition).

The **set of rules** governing how names interact when combining program fragments, addressing whether bindings shadow, conflict, or merge (central to understanding substitution, scope, and module composition).

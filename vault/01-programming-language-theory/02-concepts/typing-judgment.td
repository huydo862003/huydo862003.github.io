---
_type: PltConcept
_label: 'Typing judgment'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'semantics'
  - 'type theory'
tags:
  - 'logic'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A formal statement asserting that a term has a particular type under a given ${fref("/01-programming-language-theory/02-concepts/type-environment.td")}, typically written as $\Gamma \vdash t : T$.

---
_type: PltConcept
_label: 'Halt'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The terminal state of an ${fref("/01-programming-language-theory/02-concepts/abstract-machine.td")} reached when the current term is in ${fref("/01-programming-language-theory/02-concepts/normal-form.td")} (i.e., no evaluation rule applies), signaling completion of evaluation.

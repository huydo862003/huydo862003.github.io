---
_type: PltConcept
_label: 'Type environment'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'type theory'
tags:
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mapping from variable names to their types, often written as $\Gamma$, that tracks type bindings in scope during ${fref("/01-programming-language-theory/02-concepts/type-checker.td")} analysis, extended when entering new binding forms.

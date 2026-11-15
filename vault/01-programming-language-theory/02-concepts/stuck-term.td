---
_type: PltConcept
_label: 'Stuck term'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/lambda-calculus.td")} term that is in ${fref("/01-programming-language-theory/02-concepts/normal-form.td")} but not a value.

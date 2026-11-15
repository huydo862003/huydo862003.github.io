---
_type: PltConcept
_label: 'Safety check'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'language feature/design'
  - 'programming paradigm'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mechanism, either carried out by the runtime to enforce ${fref("/01-programming-language-theory/02-concepts/language-safety.td")} / avoid ${fref("/01-programming-language-theory/02-concepts/runtime-type-error.td")} or by programmers to avoid ${fref("/01-programming-language-theory/02-concepts/runtime-error.td")}.

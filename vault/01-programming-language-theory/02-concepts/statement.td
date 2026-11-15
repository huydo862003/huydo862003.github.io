---
_type: PltConcept
_label: 'Statement'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/term.td")} that does not evaluate to a value, but rather cause a ${fref("/01-programming-language-theory/02-concepts/side-effect.td")}.

---
_type: PltConcept
_label: 'Surface language'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The user-facing syntax of a programming language, including ${fref("/01-programming-language-theory/02-concepts/syntactic-sugar.td")} and conveniences, as opposed to the ${fref("/01-programming-language-theory/02-concepts/core-calculus-language.td")} that programs are desugared into.

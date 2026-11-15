---
_type: PltConcept
_label: 'Multiple inheritance'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/programming-language-theory/concepts/inheritance.td")} model where a class can inherit from multiple parent classes, combining their behaviors but potentially introducing ambiguity (${fref("/programming-language-theory/concepts/the-diamond-problem.td")}) when parents share method names.

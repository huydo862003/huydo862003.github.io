---
_type: PltConcept
_label: 'Core calculus/language'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A minimal formal language capturing the essential features of a paradigm or language, used to study semantics and prove properties without the complexity of full-scale syntax.

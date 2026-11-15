---
_type: PltConcept
_label: 'Concrete/Surface syntax'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The textual representation programmers actually write, including parentheses, keywords, and punctuation - as opposed to ${fref("/01-programming-language-theory/02-concepts/structural-abstract-syntax.td")} which captures only the essential structure.

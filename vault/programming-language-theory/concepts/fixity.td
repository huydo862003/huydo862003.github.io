---
_type: PltConcept
_label: 'Fixity'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic property specifying an operator's position relative to its arguments: prefix (-x), infix (x + y), or postfix (x!).

A **syntactic property** specifying an operator's position relative to its arguments: prefix (`-x`), infix (`x + y`), or postfix (`x!`).

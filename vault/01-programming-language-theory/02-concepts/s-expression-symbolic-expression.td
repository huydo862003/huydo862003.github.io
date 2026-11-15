---
_type: PltConcept
_label: 'S-expression/Symbolic expression'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A notation for nested list-structured data, defined recursively as either an atom (e.g., number, symbol) or a parenthesized list of S-expressions - the uniform syntax used in Lisp for both code and data.

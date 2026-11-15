---
_type: PltConcept
_label: 'Variadic tree'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A tree structure where operators can take a variable (not fixed) number of arguments, with that number determined by a ${fref("/programming-language-theory/concepts/symbol.td")} index.

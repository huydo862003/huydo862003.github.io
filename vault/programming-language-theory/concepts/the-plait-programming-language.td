---
_type: PltConcept
_label: 'The plait programming language'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A dialect of Lisp, based on Racket, but with ${fref("/programming-language-theory/concepts/type-system.td")} resembling that of ML.

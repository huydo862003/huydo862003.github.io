---
_type: PltConcept
_label: 'Object'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A multi-entrypoint ${fref("/01-programming-language-theory/02-concepts/closure.td")} that can be accessed using ${fref("/01-programming-language-theory/02-concepts/message-passing.td")}.

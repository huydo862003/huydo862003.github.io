---
_type: PltConcept
_label: 'Object'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A multi-entrypoint ${fref("/programming-language-theory/concepts/closure.td")} that can be accessed using ${fref("/programming-language-theory/concepts/message-passing.td")}.

---
_type: PltConcept
_label: 'Object language'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The formal language being defined, analyzed, or reasoned about - as opposed to the ${fref("/programming-language-theory/concepts/metalanguage.td")} used to describe it.

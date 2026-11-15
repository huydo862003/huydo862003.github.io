---
_type: PltConcept
_label: 'Automatic memory management'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A language or runtime mechanism that handles allocation and deallocation of memory without explicit programmer intervention - encompassing techniques like ${fref("/programming-language-theory/concepts/garbage-collection.td")}, reference counting, and ownership systems.

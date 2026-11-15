---
_type: PltConcept
_label: 'Meta-mathematics'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'other mathematics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The study of mathematical systems themselves using mathematical methods - analyzing properties like consistency, completeness, and decidability of formal theories.

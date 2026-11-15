---
_type: PltConcept
_label: 'Static discipline'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'program analysis'
  - 'syntax & grammar'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An approach where ${fref("/programming-language-theory/concepts/static-analysis.td")} and other analyses are performed before program execution, catching errors at compile time rather than runtime. Contrasts with dynamic discipline.

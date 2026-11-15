---
_type: PltConcept
_label: 'Model checker'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An automated verification technique that exhaustively explores the state space of a (typically finite-state) system to detect violations of specified properties such as safety, liveness, or protocol correctness.

---
_type: PltConcept
_label: 'Conservative'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type checker that considers all possible executions rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runt

A type checker that considers **all possible executions** rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runtime.

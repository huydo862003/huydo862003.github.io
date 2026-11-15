---
_type: PltConcept
_label: 'Sequential evaluation'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'concurrency theory'
  - 'language feature/design'
  - 'runtime'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An execution model where expressions or statements are evaluated one after another in a specified order, with each completing before the next begins - the default in imperative languages, contrasted with parallel or concurrent evaluation.

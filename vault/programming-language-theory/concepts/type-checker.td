---
_type: PltConcept
_label: 'Type checker'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'type theory'
tags:
  - 'compiler implementation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A program or algorithm that verifies type correctness by analyzing program text and ensuring expressions conform to typing rules before execution.

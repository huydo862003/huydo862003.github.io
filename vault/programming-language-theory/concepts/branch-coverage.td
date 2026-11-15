---
_type: PltConcept
_label: 'Branch coverage'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
tags:
  - 'design principle'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A testing metric requiring that every branch (true/false of each conditional) is executed at least once - difficult to achieve in testing but automatic in type checking since type checkers traverse bo

A testing metric requiring that **every branch** (true/false of each conditional) is executed at least once - difficult to achieve in testing but **automatic** in type checking since type checkers traverse both branches of conditionals.

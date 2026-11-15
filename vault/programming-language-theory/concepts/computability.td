---
_type: PltConcept
_label: 'Computability'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of a mathematical problem that can be solved by a program.

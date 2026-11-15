---
_type: PltConcept
_label: 'Directed acyclic graph (DAG)'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

- Edges have a direction (from one node to another).
- There are no cycles (you can't follow edges and return to where you started).

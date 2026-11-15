---
_type: PltConcept
_label: 'Labeled tree'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast).

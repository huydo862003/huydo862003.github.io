---
_type: PltConcept
_label: 'Operator'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to Practical foundations for programming languages , an interior node of an [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast), with a specified Arity $(s_1;\dots; s_n)s$, for $s_i \in \mathcal{S}$ - the set of Sorts.

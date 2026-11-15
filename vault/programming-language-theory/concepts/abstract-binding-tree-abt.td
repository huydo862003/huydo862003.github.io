---
_type: PltConcept
_label: 'Abstract binding tree (ABT)'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An enriched [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast) with bindings and scopes. According to Practical foundations for programming languages , each node in an ABT is either a Variable or an Operator whose arguments are ${fref("/programming-language-theory/concepts/abstractor.td")}s.

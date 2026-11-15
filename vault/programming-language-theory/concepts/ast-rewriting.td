---
_type: PltConcept
_label: 'AST rewriting'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A program transformation technique that modifies the ${fref("/programming-language-theory/concepts/abstract-syntax-tree-ast.td")} to implement features like ${fref("/programming-language-theory/concepts/macro.td")}s, optimizations, or language extensions before code generation.

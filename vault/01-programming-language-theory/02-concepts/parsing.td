---
_type: PltConcept
_label: 'Parsing'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Compiler implementation) The process of converting Concrete/Surface syntax into [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast)s.
:::

::: info
(Syntax & Grammar, Linguistics) The process of converting a text into the terms of a Context-free grammar.
:::

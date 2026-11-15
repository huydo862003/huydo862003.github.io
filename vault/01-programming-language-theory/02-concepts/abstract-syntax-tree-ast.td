---
_type: PltConcept
_label: 'Abstract syntax tree (AST)'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , a tree representation of a term's essential structure (not necessarily a program), omitting superficial syntactic details like parentheses, delimiters, and keywords. Can be of some specified Sorts.
:::

Structure-wise, an ordered tree whose:

- Leaves are Variables/Operators.
- Internal nodes are Operators.
- Operators have Actual parameter/Arguments as children.

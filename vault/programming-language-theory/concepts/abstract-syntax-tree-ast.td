---
_type: PltConcept
_label: 'Abstract syntax tree (AST)'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
  - fref("programming-language-theory/books/practical-foundations-for-programming-languages/chapter-1-abstract-syntax.td")
tags:
  - 'compiler implementation'
  - 'syntax grammar'
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , a tree representation of a term's essential structure (not necessarily a program), omitting superficial syntactic details like parentheses, delimiters, and keywords. Can be of some specified Sorts.
:::

Structure-wise, an ordered tree whose:

- Leaves are Variables/Operators.
- Internal nodes are Operators.
- Operators have Actual parameter/Arguments as children.

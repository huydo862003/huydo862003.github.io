---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Abstract syntax tree (AST)"
journey: plt
status: mastered
tags: ["compiler-implementation", "syntax-grammar"]
books: ["chapter-5-the-untyped-pure-lambda-calculus", "chapter-1-abstract-syntax"]
dependsOn: []
blocks: []
---
:::key
(Syntax & Grammar) According to Practical foundations for programming languages , a tree representation of a term's essential structure (not necessarily a program), omitting superficial syntactic details like parentheses, delimiters, and keywords. Can be of some specified Sorts.
:::

Structure-wise, an ordered tree whose:

- Leaves are Variables/Operators.
- Internal nodes are Operators.
- Operators have Actual parameter/Arguments as children.

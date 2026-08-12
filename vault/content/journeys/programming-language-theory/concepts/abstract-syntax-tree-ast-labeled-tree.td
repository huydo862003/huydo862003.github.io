---
_type: Concept
title: 'Abstract syntax tree ast labeled tree'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , a tree representation of a term's essential structure (not necessarily a program), omitting superficial syntactic details like parentheses, delimiters, and keywords. Can be of some specified Sorts.
:::

Structure-wise, an ordered tree whose:

- Leaves are Variables/Operators.
- Internal nodes are Operators.
- Operators have ${fref("journeys/programming-language-theory/concepts/actual-parameter-argument.td")}s as children.

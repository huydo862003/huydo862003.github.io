---
_type: Concept
title: 'Abstract binding tree (ABT)'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/practical-foundations-for-programming-languages/chapter-1-abstract-syntax.td")
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
tags:
  - 'compiler-implementation'
  - 'semantics'
  - 'syntax-grammar'
---

An enriched [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast) with bindings and scopes. According to Practical foundations for programming languages , each node in an ABT is either a Variable or an Operator whose arguments are ${fref("programming-language-theory/concepts/abstractor.td")}s.

---
_type: PltConcept
_label: 'Abstract binding tree (ABT)'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/practical-foundations-for-programming-languages/01-part-i-judgments-and-rules/01-chapter-1-abstract-syntax.td")
  - fref("programming-language-theory/books/software-foundations/01-logical-foundations/02-chapter-2-inductive-definitions.td")
tags:
  - 'compiler implementation'
  - 'semantics'
  - 'syntax grammar'
---

An enriched [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast) with bindings and scopes. According to Practical foundations for programming languages , each node in an ABT is either a Variable or an Operator whose arguments are ${fref("programming-language-theory/concepts/abstractor.td")}s.

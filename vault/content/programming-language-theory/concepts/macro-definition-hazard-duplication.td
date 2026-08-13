---
_type: Concept
_label: 'Macro definition hazard: duplication'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
tags:
  - 'compiler-implementation'
  - 'design-principle'
  - 'metaprogramming-self-reflection'
---

A ${fref("programming-language-theory/concepts/macro.td")} pitfall where an expression passed as argument is evaluated multiple times in the ${fref("programming-language-theory/concepts/macro-expansion.td")}, causing unintended repeated ${fref("programming-language-theory/concepts/side-effect.td")}s or performance issues.

---
_type: PltConcept
_label: 'Recursive macro'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
tags:
  - 'compiler implementation'
  - 'language feature design'
  - 'metaprogramming self reflection'
  - 'programming paradigm'
---

A ${fref("programming-language-theory/concepts/macro.td")} that can expand to code containing further macro invocations, including calls to itself. Enables powerful metaprogramming but requires careful handling to ensure termination.

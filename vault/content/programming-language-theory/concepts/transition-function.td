---
_type: Concept
_label: 'Transition function'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-3-untyped-arithmetic-expressions.td")
tags:
  - 'computation-theory'
  - 'semantics'
---

A ${fref("programming-language-theory/concepts/partial-function.td")} from machine configurations (term, environment, stack, etc.) to successor configurations, defining each atomic step of execution until a final state is reached. In ${fref("programming-language-theory/concepts/lambda-calculus.td")} with [Small-step/Structural operational semantics (SOS)](/plt/concepts/small-step-structural-operational-semantics-sos), the transition function usually relates a term with a simplification of that term, and is undefined for ${fref("programming-language-theory/concepts/normal-form.td")}s.

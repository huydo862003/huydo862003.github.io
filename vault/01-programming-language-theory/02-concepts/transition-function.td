---
_type: PltConcept
_label: 'Transition function'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
tags:
  - 'computation theory'
  - 'semantics'
tags:
  - 'computation theory'
  - 'semantics'
---

A ${fref("/01-programming-language-theory/02-concepts/partial-function.td")} from machine configurations (term, environment, stack, etc.) to successor configurations, defining each atomic step of execution until a final state is reached. In ${fref("/01-programming-language-theory/02-concepts/lambda-calculus.td")} with [Small-step/Structural operational semantics (SOS)](/plt/concepts/small-step-structural-operational-semantics-sos), the transition function usually relates a term with a simplification of that term, and is undefined for ${fref("/01-programming-language-theory/02-concepts/normal-form.td")}s.

---
_type: Concept
title: 'Arrow type'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/practical-foundations-for-programming-languages/preface.td")
tags:
  - 'formal-system'
  - 'language-feature-design'
  - 'type-theory'
---

This generalization unifies simple function types, universal types ($\\forall\\alpha.T$), and dependent function types under a single constructor.

- In simple type systems: $T_1 \to T$₂, classifying functions from $T_1$ to $T_2$, where the result type is independent of the input.
- In ${fref("journeys/programming-language-theory/concepts/pure-type-system.td")}s: generalized to the ${fref("journeys/programming-language-theory/concepts/dependent-type.td")} product  $\Pi(x:T_1).T_2$, where the result type $T_2$ may depend on the input value $x$.
- The simple arrow $T_1 \to T_2$  is the special case where $T_2$ does not mention $x$.

This generalization unifies simple function types, universal types ($\forall\alpha.T$), and dependent function types under a single constructor.

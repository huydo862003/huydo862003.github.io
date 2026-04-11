---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Arrow type"
description: "This generalization unifies simple function types, universal types ($\\forall\\alpha.T$), and dependent function types under a single constructor."
journey: plt
status: learning
books: ["preface"]
dependsOn: []
blocks: []
tags:
  - "formal-system"
  - "language-feature-design"
  - "type-theory"
  - "type"
  - "simple"
  - "types"
  - "arrow"
  - "systems"
  - "result"
  - "input"
  - "dependent"
  - "function"
---

- In simple type systems: $T_1 \to T$₂, classifying functions from $T_1$ to $T_2$, where the result type is independent of the input.
- In Pure type systems: generalized to the dependent product  $\Pi(x:T_1).T_2$, where the result type $T_2$ may depend on the input value $x$.
- The simple arrow $T_1 \to T_2$  is the special case where $T_2$ does not mention $x$.

This generalization unifies simple function types, universal types ($\forall\alpha.T$), and dependent function types under a single constructor.

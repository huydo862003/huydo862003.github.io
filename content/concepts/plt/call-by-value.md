---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Call by value"
description: "(Lambda calculus, Semantics) A Strict/Eager evaluation strategy in which Beta-redex/Reducible expressions inside lambda abstractions must not be reduced."
journey: plt
status: mastered
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "semantics"
keywords:
  - "lambda"
  - "calculus"
  - "strategy"
  - "displaystyle"
  - "frac"
  - "call"
  - "value"
  - "key"
  - "strict"
---
author: hdnax
:::key
(Lambda calculus, Semantics) A Strict/Eager evaluation strategy in which Beta-redex/Reducible expressions inside lambda abstractions must not be reduced.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{v_1\ t_2 \to v_1\ t_2'}$
- $(\lambda x.\ t)\ v \to [x \to v] t$

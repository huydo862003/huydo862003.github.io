---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Call by name"
description: "(Lambda calculus, Semantics) An evaluation strategy that is Normal order but Beta-reduction inside Lambda abstraction is not allowed."
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
  - "call"
  - "name"
  - "key"
  - "evaluation"
  - "normal"
  - "order"
---
:::key
(Lambda calculus, Semantics) An evaluation strategy that is Normal order but Beta-reduction inside Lambda abstraction is not allowed.
:::

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

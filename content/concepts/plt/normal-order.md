---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Normal order"
description: "In pure lambda calculus, this strategy is defined by the following rules:"
journey: plt
status: mastered
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "semantics"
keywords:
  - "lambda"
  - "displaystyle"
  - "frac"
  - "normal"
  - "quad"
  - "text"
  - "order"
  - "pure"
  - "calculus"
  - "strategy"
---
author: hdnax

In pure lambda calculus, this strategy is defined by the following rules:

- $(\lambda x.\ t_1)\ t_2 \to [x \mapsto t_2]\, t_1$
- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \quad (t_1 \text{ is not a } \lambda)$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'} \quad (t_1 \text{ in normal form})$
- $\displaystyle \frac{t \to t'}{\lambda x.\ t \to \lambda x.\ t'}$

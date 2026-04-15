---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Full beta-reduction"
journey: plt
status: mastered
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "semantics"
---

In pure lambda calculus, this strategy is defined by the following rules:

- $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2}$
- $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'}$
- $\displaystyle \frac{t_2 \to t_2'}{\lambda x.\ t_2 \to \lambda x.\ t_2' }$
- $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$

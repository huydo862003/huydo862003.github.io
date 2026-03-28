---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Church numeral
journey: plt
status: learning
tags: []
books:
  - chapter-5-the-untyped-pure-lambda-calculus
dependsOn: []
blocks: []
---

Tools: Rocq (formerly Coq)
:::key
(Semantics, Lambda calculus) Church's encoding of numbers used in pure lambda calculus.
:::

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

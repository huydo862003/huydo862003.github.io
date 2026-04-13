---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Church numeral
description: "\"Church numeral\" is a concept in plt (status: learning)."
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
dependsOn: []
blocks: []
tags: []
keywords:
  - "lambda"
  - "calculus"
  - "encoding"
  - "cdots"
  - "church"
  - "numeral"
  - "tools"
  - "rocq"
  - "formerly"
  - "coq"
---
author: hdnax

Tools: Rocq (formerly Coq)
:::key
(Semantics, Lambda calculus) Church's encoding of numbers used in pure lambda calculus.
:::

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

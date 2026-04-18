---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Church numeral
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
dependsOn: []
blocks: []
tags: []
---

Tools: Rocq (formerly Coq)
- (Semantics, Lambda calculus) Church's encoding of numbers used in pure lambda calculus.

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Fixed-point combinator
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
  - chapter-1-basics-functional-programming-in-rocq
dependsOn: []
blocks: []
tags: []
---

Tools: Rocq (formerly Coq)
- (Lambda calculus, Semantics) A combinator that finds a fixed-point of a functional (a function that takes a function and returns another function). There are many such combinators, such as the Curry combinator (Y-combinator) or the Z-combinator. Formally, a fixed-point combinator is a combinator $\text{fix}$ such that for any functional $g$, $\text{fix}\ g$ is beta/eta-equivalent to $g\ (\text{fix}\ g)$.

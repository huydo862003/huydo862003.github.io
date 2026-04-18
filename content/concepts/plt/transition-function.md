---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Transition function
journey: plt
status: reviewing
books:
  - chapter-3-untyped-arithmetic-expressions
dependsOn: []
blocks: []
tags:
  - computation-theory
  - semantics
---

A Partial function from machine configurations (term, environment, stack, etc.) to successor configurations, defining each atomic step of execution until a final state is reached. In Lambda calculus with [Small-step/Structural operational semantics (SOS)](/journeys/plt/concepts/small-step-structural-operational-semantics-sos), the transition function usually relates a term with a simplification of that term, and is undefined for normal forms.

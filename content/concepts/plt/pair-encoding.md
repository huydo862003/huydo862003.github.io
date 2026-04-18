---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Pair encoding
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
dependsOn: []
blocks: []
tags:
  - lambda-calculus
  - semantics
---

Encoding:

- $\text{pair} = \lambda f.\ \lambda s.\ \lambda t.\ t\ f\ s$
- $\text{fst} = \lambda p.\ p\  \text{tru}$
- $\text{snd} = \lambda p.\ p\ \text{fls}$

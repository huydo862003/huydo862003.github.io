---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Pair encoding"
description: "\"Pair encoding\" is a concept in plt (status: learning). Topics: lambda-calculus, semantics."
journey: plt
status: learning
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "lambda-calculus"
  - "semantics"
keywords:
  - "text"
  - "lambda"
  - "pair"
  - "encoding"
  - "fst"
  - "tru"
  - "snd"
  - "fls"
---

Encoding:

- $\text{pair} = \lambda f.\ \lambda s.\ \lambda t.\ t\ f\ s$
- $\text{fst} = \lambda p.\ p\  \text{tru}$
- $\text{snd} = \lambda p.\ p\ \text{fls}$

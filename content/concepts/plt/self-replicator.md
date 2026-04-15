---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Self-replicator"
journey: plt
status: learning
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "lambda-calculus"
  - "semantics"
---

\\text{fibo} = \\text{fix}\\ \\lambda f.\\ \\lambda n.\\ \\text{if}\\ n = 0\\ \\text{or}\\ n = 1\\ \\text{then}\\ 1\\ \\text{else}\\ (f\\ (n - 1)) + (f\\ (n - 2))

Example:

$$
\text{fibo} = \text{fix}\ \lambda f.\ \lambda n.\ \text{if}\ n = 0\ \text{or}\ n = 1\ \text{then}\ 1\ \text{else}\ (f\ (n - 1)) + (f\ (n - 2))  
$$

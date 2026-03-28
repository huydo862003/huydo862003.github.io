---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Variable capture"
journey: plt
status: learning
tags: ["lambda-calculus", "semantics"]
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
---

Example:

$$
(\lambda x.\ \lambda y.\ x)\ y \to [x \to y] \lambda y.\ x = \lambda y.\ y
$$

So, $y$ was a free variable and not bound by the $\lambda y$ binder in the first term, but then become bound in the resulting term.

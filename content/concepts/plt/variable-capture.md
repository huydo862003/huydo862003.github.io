---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Variable capture
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

(\\lambda x.\\ \\lambda y.\\ x)\\ y \\to [x \\to y] \\lambda y.\\ x = \\lambda y.\\ y

Example:

$$
(\lambda x.\ \lambda y.\ x)\ y \to [x \to y] \lambda y.\ x = \lambda y.\ y
$$

So, $y$ was a free variable and not bound by the $\lambda y$ binder in the first term, but then become bound in the resulting term.

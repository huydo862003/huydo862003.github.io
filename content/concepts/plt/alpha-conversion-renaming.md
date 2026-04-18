---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Alpha conversion/renaming
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

(\\lambda x.\\ \\lambda y.\\ x)\\ y \\to [x \\to y] \\lambda y.\\ x

Example:

$$
(\lambda x.\ \lambda y.\ x)\ y \to [x \to y] \lambda y.\ x
$$

Without alpha-conversion, performing a naive substitution would result in:

$$
[x \to y]\lambda y.\ x = \lambda y.\ \ y
$$

So, a function that was always returning a constant $x$ becomes an identity function.

With alpha-conversion, we can correctly perform a substitution:

$$
[x \to y] \lambda y.\ x = [x \to y]\lambda z.\ x = \lambda z.\ y
$$

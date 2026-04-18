---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Capture-avoiding substitution
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
  - chapter-1-abstract-syntax
dependsOn: []
blocks: []
tags: []
---

Rules in Pure/Untyped lambda calculus:

- $[x\to s]x = s$
- $[x\to s ]y = y\ \text{if}\ x \neq y$
- 
$$
[x\to s]\lambda y.\ t = \begin{cases} \lambda y.\ [x\to s]t & \text{if}\ y \neq x \land y \notin FV(s) \\ \lambda y.\ t & \text{if}\ y = x \end{cases}
$$

- $[x \to s](t_1\ t_2) = [x \to s]t_1\ [x \to s]t_2$
- Practical foundations for programming languages 's notation
    
    A substitution $[b / x]$ is a partial function on the set of ASTs $\mathcal{A}$. Given the set of variables $\mathcal{X}$ and an AST $a \in \mathcal{A}$:
    
    - If $a = x \in \mathcal{X}$ then $[b/x]a = b$.
    - If $a = y \in \mathcal{X}$ and $y \neq x$ then $[b/x]y = y$.
    - $[b/x]o(\vec{x}_1.a_1; \ldots; \vec{x}_n.a_n) = o(\vec{x}_1.a'_1; \ldots; \vec{x}_n.a'_n)$, where for each $1 \leq i \leq n$, we require that $\vec{x}_i \notin b$, and we set $a'_i = [b/x]a_i$ if $x \notin \vec{x}_i$, and $a'_i = a_i$ otherwise.

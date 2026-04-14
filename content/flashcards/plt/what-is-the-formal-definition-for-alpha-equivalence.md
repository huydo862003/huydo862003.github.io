---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the formal definition for alpha-equivalence?
answer: TODO
deck: language-theory
concepts:
  - alpha-equivalence
books:
  - chapter-1-abstract-syntax
tags: []
keywords:
  - "alpha equivalence"
  - "vec"
  - "alpha"
  - "rhoi"
  - "set"
  - "asts"
  - "dots"
---


Alpha-equivalence is a relation $=_\alpha$ on the set of terms/ASTs. Given $\mathcal{A}$ as a set of ASTs. Then:

- $x =_\alpha x$.
- $o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n) =_\alpha o(\vec{x}'_1.a'_1; \dots; \vec{x}_n'.a'_n)$ if for every $1 \le i \le n$, $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho_i' : \vec{x}'_i \leftrightarrow \vec{z}_i$ and $\rho_i(a_i) =_\alpha \rho_i' (a_i')$.

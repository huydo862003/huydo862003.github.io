---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Mathematical induction
description: "Formally, assume $n\\ \\text{nat}$ means that $n$ is a natural number. To prove that whenever $n\\ \\text{nat}$, we have $\\mathcal{P}(n)$, it's sufficient to show that:"
journey: plt
status: learning
books:
  - chapter-2-inductive-definitions
dependsOn: []
blocks: []
tags: []
keywords:
  - "text"
  - "mathcal"
  - "nat"
  - "mathematical"
  - "induction"
  - "formally"
  - "assume"
  - "means"
  - "natural"
  - "number"
  - "prove"
---
author: hdnax

Formally, assume $n\ \text{nat}$ means that $n$ is a natural number. To prove that whenever $n\ \text{nat}$, we have $\mathcal{P}(n)$, it's sufficient to show that:

1. $\mathcal{P}(\text{zero})$.
2. For every $n$ such that $n\ \text{nat}$, if $\mathcal{P}(n)$ then $\mathcal{P}(\text{succ}(n))$.

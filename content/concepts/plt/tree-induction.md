---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Tree induction
journey: plt
status: learning
books:
  - chapter-2-inductive-definitions
dependsOn: []
blocks: []
tags: []
---

Formally, assume $a\\ \\text{tree}$ means that $a$ is a binary tree. To prove that whenever $a\\ \\text{tree}$, we have $\\mathcal{P}(a)$, it's sufficient to show that:

Formally, assume $a\ \text{tree}$ means that $a$ is a binary tree. To prove that whenever $a\ \text{tree}$, we have $\mathcal{P}(a)$, it's sufficient to show that:

1. $\mathcal{P}(\text{empty)}$.
2. For every $a_1$ and $a_2$ such that $a_1\ \text{tree}$ and $a_2\ \text{tree}$, if $\mathcal{P}(a_1)$ and $\mathcal{P}(a_2)$ then $\mathcal{P}(\text{node}(a_1;a_2))$.

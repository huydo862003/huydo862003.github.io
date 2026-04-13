---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Concrete generator style"
description: "A style of formal definition that defines a set as a union of a sequence $S_0 \\subseteq S_1 \\subseteq \\dots$  where each $S_i+_1$ is built from $S_i$ using rules - e.g., for naturals: $S_0 = \\emptyset"
journey: plt
status: learning
books: ["chapter-3-untyped-arithmetic-expressions"]
dependsOn: []
blocks: []
tags:
  - "set-theory-relation"
  - "syntax-grammar"
keywords:
  - "style"
  - "subseteq"
  - "cup"
  - "concrete"
  - "generator"
  - "formal"
  - "defines"
  - "set"
  - "union"
  - "sequence"
---
author: hdnax

A style of formal definition that defines a set as a union of a sequence $S_0 \subseteq S_1 \subseteq \dots$  where each $S_i+_1$ is built from $S_i$ using rules - e.g., for naturals: $S_0 = \emptyset$, $S_i+_1 = S_i \cup {0} \cup {succ(n) | n \in S_i}, \mathbb{N} = \bigcupS_i$.

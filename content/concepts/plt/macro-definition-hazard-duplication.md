---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Macro definition hazard: duplication"
journey: plt
status: reviewing
books: ["chapter-3-syntactic-sugar"]
dependsOn: []
blocks: []
tags:
  - "compiler-implementation"
  - "design-principle"
  - "metaprogramming-self-reflection"
---

A macro pitfall where an expression passed as argument is evaluated multiple times in the expansion, causing unintended repeated side-effects or performance issues.

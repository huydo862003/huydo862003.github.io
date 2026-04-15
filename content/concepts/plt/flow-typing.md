---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Flow typing"
journey: plt
status: mastered
books: ["chapter-5-types"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "program-analysis"
  - "runtime"
  - "semantics"
  - "type-theory"
---

A type system feature where a variable's type changes based on control flow - after if (x != null), the type of x narrows from T | null to T.

A type system feature where a variable's type **changes** based on control flow - after `if (x != null)`, the type of `x` narrows from `T | null` to `T`.

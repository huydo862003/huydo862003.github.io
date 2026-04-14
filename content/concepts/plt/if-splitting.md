---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: If-splitting
description: "A type system mechanism where conditionals narrow union types based on predicates - after if (mt? t), the type of t refines from BT (union) to just mt in that branch, implementing Flow-sensitive typin"
journey: plt
status: learning
books:
  - chapter-5-types
dependsOn: []
blocks: []
tags: []
keywords:
  - "type"
  - "union"
  - "if-splitting"
  - "system"
  - "mechanism"
  - "conditionals"
  - "narrow"
  - "types"
  - "based"
  - "predicates"
---

A type system mechanism where **conditionals narrow union types** based on predicates - after `if (mt? t)`, the type of `t` refines from `BT` (union) to just `mt` in that branch, implementing Flow-sensitive typing.

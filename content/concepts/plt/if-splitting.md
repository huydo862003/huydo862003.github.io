---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: If-splitting
journey: plt
status: learning
tags: []
books:
  - chapter-5-types
dependsOn: []
blocks: []
---

A type system mechanism where **conditionals narrow union types** based on predicates - after `if (mt? t)`, the type of `t` refines from `BT` (union) to just `mt` in that branch, implementing Flow-sensitive typing.

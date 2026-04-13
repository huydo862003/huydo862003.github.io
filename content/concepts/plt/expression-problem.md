---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Expression problem
description: "Neither paradigm naturally supports both dimensions of extensibility without modifying existing code or sacrificing type safety. Solutions exist (type classes, object algebras, tagless final) but invo"
journey: plt
status: learning
books:
  - chapter-5-types
dependsOn: []
blocks: []
tags: []
keywords:
  - "add"
  - "functions"
  - "existing"
  - "classes"
  - "variants"
  - "must"
  - "edit"
  - "type"
  - "expression"
  - "problem"
---
author: hdnax

| Approach | Easy to add | Hard to add |
| --- | --- | --- |
| **Algebraic datatypes + functions** | New **functions** (just define another) | New **variants** (must edit all existing functions) |
| **OO classes + methods** | New **variants** (just add subclass) | New **operations** (must edit all existing classes) |

Neither paradigm naturally supports **both dimensions** of extensibility without modifying existing code or sacrificing type safety. Solutions exist (type classes, object algebras, tagless final) but involve trade-offs.

---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Assume-guarantee reasoning"
journey: plt
status: mastered
books: ["chapter-5-types"]
dependsOn: []
blocks: []
tags:
  - "proof-reason-technique"
---

A pattern where interacting components have mutual obligations - one component assumes what another guarantees, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it; 

A pattern where interacting components have **mutual obligations** - one component **assumes** what another **guarantees**, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it; application assumes function returns $U$, lambda guarantees it).

---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Subgoal"
description: "\"Subgoal\" is a concept in plt (status: reviewing). Topics: language-feature-design, logic, proof-reason-technique."
journey: plt
status: reviewing
books: ["chapter-1-basics-functional-programming-in-rocq"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "logic"
  - "proof-reason-technique"
keywords:
  - "rocq"
  - "goal"
  - "formal"
  - "system"
  - "reason"
  - "technique"
  - "splits"
  - "multiple"
  - "subgoal"
---

Tools: Rocq (formerly Coq)
:::key
(Formal system, Proof/Reason technique, Logic) A **subsidiary goal** generated when a proof splits into multiple cases, each requiring independent proof before the original goal is resolved.
:::
:::key
(Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) [Rocq] In Rocq, a **derived goal** created when a tactic splits the proof into multiple obligations (e.g., one per constructor or conjunct), all of which must be discharged.
:::

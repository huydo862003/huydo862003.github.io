---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Double negation elimination"
description: "holds. It asserts that if it is false that $A$ is false, then $A$ is true."
journey: plt
status: reviewing
books: []
dependsOn: []
blocks: []
tags:
  - "logic"
  - "syntax-grammar"
keywords:
  - "neg"
  - "double"
  - "negation"
  - "elimination"
  - "holds"
  - "asserts"
  - "classical"
  - "accepts"
  - "intuitionistic"
---

$$
\neg\neg A \to A
$$

holds. It asserts that if it is false that $A$ is false, then $A$ is true.

**Remark.** Classical logic accepts this. Intuitionistic/Constructive logic rejects it: showing that $\neg A$ leads to contradiction is not the same as constructing a proof of $A$. You have ruled something out, but you have not built the required witness.

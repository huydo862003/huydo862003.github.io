---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Environment
journey: plt
status: learning
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
tags: []
---

(Lambda calculus, Semantics) A finite map from variables to values, used to track substitutions during evaluation.

:::key
(Lambda calculus, Semantics) A finite map from variables to values, used to track substitutions during evaluation.
:::

- Written as: `{x ↦ 5, y ↦ 3}` or `[x := 5, y := 3]`.
- Extended when entering a function body: `env[x ↦ v]`.
- Consulted when evaluating a variable: `env(x)`.

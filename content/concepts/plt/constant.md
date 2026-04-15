---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Constant"
journey: plt
status: mastered
books: ["chapter-2-evaluation"]
dependsOn: []
blocks: []
tags:
  - "compiler-implementation"
  - "language-feature-design"
  - "program-analysis"
  - "semantics"
  - "syntax-grammar"
---

The token itself *is* the value-the parser can extract it directly without consulting any environment or performing computation

- Requires no evaluation or name lookup.
- Examples: `42`, `"hello"`, `true`, `3.14`.
- Also called: Literal, *self-evaluating expression.*

The token itself *is* the value-the parser can extract it directly without consulting any environment or performing computation
:::key
(Semantics, Semantics, Language feature/design, Program analysis) (a.k.a **semantic constant**) A declaration that restricts mutability of a binding and/or its value.
:::

- **Constant binding**: Name cannot be reassigned to a different reference (JavaScript `const`, Java `final`).
- **Constant value**: The underlying data cannot be modified (C++ `const`, Rust default).
- Some languages enforce both; others only one.

---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Autoboxing"
description: "\"Autoboxing\" is a concept in plt (status: learning). Topics: language-feature-design, runtime, semantics."
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "runtime"
  - "semantics"
keywords:
  - "primnum"
  - "number"
  - "autoboxing"
  - "tsx"
  - "const"
  - "console"
  - "log"
  - "tostring"
  - "implicitly"
---

Example:

```tsx
const primNum: number = 3;

console.log(
	primNum.toString() // primNum is implicitly converted to `Number`
);
```

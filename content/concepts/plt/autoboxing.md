---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Autoboxing"
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "runtime"
  - "semantics"
---

Example:

```tsx
const primNum: number = 3;

console.log(
	primNum.toString() // primNum is implicitly converted to `Number`
);
```

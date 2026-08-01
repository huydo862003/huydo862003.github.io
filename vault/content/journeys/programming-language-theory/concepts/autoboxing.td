---
_type: Concept
title: 'Autoboxing'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language-feature-design'
  - 'runtime'
  - 'semantics'
---

Example:

```tsx
const primNum: number = 3;

console.log(
	primNum.toString() // primNum is implicitly converted to `Number`
);
```

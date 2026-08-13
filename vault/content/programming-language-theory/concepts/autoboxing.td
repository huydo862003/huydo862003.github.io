---
_type: Concept
_label: 'Autoboxing'
title: 'Autoboxing'
journey: fref("programming-language-theory/index.td")
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

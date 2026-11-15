---
_type: PltConcept
_label: 'Autoboxing'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language feature/design'
  - 'runtime'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example:

```tsx
const primNum: number = 3;

console.log(
	primNum.toString() // primNum is implicitly converted to `Number`
);
```

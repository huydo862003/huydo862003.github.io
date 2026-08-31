---
_type: PltConcept
_label: 'Tuple rocq'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

Multiple fields inside a constructor.

```coq
Inductive nybble : Type :=
	| bits (b1 b2 b3 b4 : bit)
```

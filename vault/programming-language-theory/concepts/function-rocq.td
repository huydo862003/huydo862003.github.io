---
_type: PltConcept
_label: 'Function rocq'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

Use the `Fixpoint` definition. For example:

```coq
Fixpoint even (n : nat) : bool :=
	match n with
		| O => true
		| S O => false
		| S (S n') => even n'
	end.
```

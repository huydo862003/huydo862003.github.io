---
_type: Concept
title: 'Function rocq'
journey: fref("journeys/programming-language-theory/index.td")
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

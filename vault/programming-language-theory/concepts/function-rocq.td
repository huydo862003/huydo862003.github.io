---
_type: PltConcept
_label: 'Function rocq'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
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

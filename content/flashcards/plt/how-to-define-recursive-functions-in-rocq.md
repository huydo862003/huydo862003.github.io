---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: "How to define recursive functions in rocq?"
answer: TODO
deck: rocq-programming-language
concepts:
  - fixed-point-combinator
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
keywords:
  - "fixed point combinator"
  - "fixpoint"
  - "coq"
  - "nat"
  - "bool"
  - "match"
  - "end"
---
author: hdnax


Use the `Fixpoint` definition. For example:

```coq
Fixpoint even (n : nat) : bool :=
	match n with
		| O => true
		| S O => false
		| S (S n') => even n'
	end.
```

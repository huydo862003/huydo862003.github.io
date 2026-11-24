---
_type: PltBook
_label: 'Exercise: negation_fn_applied_twice'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

Theorem negation_fn_applied_twice :
  forall (f : bool -> bool),
  (forall (x : bool), f x = negb x) ->
  forall (b : bool), f (f b) = b.
Proof.
  intros f.
  intros H.
  intros b.
  rewrite -> H.
  rewrite -> H.
  destruct b eqn:Eb.
  - reflexivity.
  - reflexivity.
Qed.
```

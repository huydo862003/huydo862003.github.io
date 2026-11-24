---
_type: PltBook
_label: 'Exercise: andb_eq_orb'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

Theorem andb_eq_orb :
  forall (b c : bool),
  (andb b c = orb b c) ->
  b = c.
Proof.
  intros b c.
  intros H.
  destruct b as [|] eqn:Eb.
  - simpl in H.
    rewrite <- H.
    reflexivity.
  - simpl in H.
    rewrite <- H.
    reflexivity.
Qed.
```

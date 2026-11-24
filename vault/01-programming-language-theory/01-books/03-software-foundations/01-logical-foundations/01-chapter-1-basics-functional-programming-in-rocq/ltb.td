---
_type: PltBook
_label: 'Exercise: ltb (less than)'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Inductive nat : Type :=
  | O
  | S (n : nat).

Fixpoint ltb (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => false
         | _ => true
         end
  | S n' => match m with
            | O => false
            | S m' => ltb n' m'
            end
  end.

Notation "x <? y" := (ltb x y)  (at level 70) : nat_scope.

Example test_ltb1 : (ltb 2 2) = false.
Proof. simpl. reflexivity. Qed.
Example test_ltb2 : (ltb 2 4) = true.
Proof. simpl. reflexivity. Qed.
Example test_ltb3 : (ltb 4 2) = false.
Proof. simpl. reflexivity. Qed.
```

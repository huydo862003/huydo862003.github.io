(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Inductive nat : Type :=
  | O
  | S (n : nat).

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus n' m)
  end.

Fixpoint eqb (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => true
         | S m' => false
         end
  | S n' => match m with
         | O => false
         | S m' => eqb n' m'
         end
  end.

Notation "x + y" := (plus x y)
  (at level 50, left associativity) : nat_scope.

Notation "x =? y" := (eqb x y)
  (at level 70) : nat_scope.

Theorem zero_nbeq_plus_1 : forall n : nat,
  0 =? (n + 1) = false.
Proof.
  intros [|n'].
  - reflexivity.
  - reflexivity.
Qed.

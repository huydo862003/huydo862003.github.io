(* vim:ft=coq *)

Inductive nat : Type :=
  | O
  | S (n : nat).

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus n' m)
  end.

Fixpoint mult (n m : nat) : nat :=
  match n with
  | O => O
  | S n' => plus m (mult n' m)
  end.

Notation "x + y" := (plus x y)
  (at level 50, left associativity) : nat_scope.

Notation "x * y" := (mult x y)
  (at level 40, left associativity) : nat_scope.

Fact mult_n_0 : forall p : nat,
  0 = p * 0.
Proof. Admitted.

Fact mult_n_Sm : forall n m : nat,
  n + n * m = n * S m.
Proof. Admitted.

Theorem mult_n_1 : forall p : nat,
  p * 1 = p.
Proof.
  intros p.
  rewrite <- mult_n_Sm.
  rewrite <- mult_n_0.
  reflexivity.
Qed.

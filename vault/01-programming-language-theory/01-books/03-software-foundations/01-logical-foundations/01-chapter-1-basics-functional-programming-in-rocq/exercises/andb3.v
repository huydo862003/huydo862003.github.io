(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Definition andb (b1 : bool) (b2 : bool) : bool :=
  if b1 then b2
  else false.

Definition andb3 (b1 : bool) (b2 : bool) (b3 : bool) : bool :=
  if b1 then (andb b2 b3)
  else false.

Example test_andb31: (andb3 true true true) = true.
Proof. simpl. reflexivity. Qed.
Example test_andb32: (andb3 false true true) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb33: (andb3 true false true) = false.
Proof. simpl. reflexivity. Qed.
Example test_andb34: (andb3 true true false) = false.
Proof. simpl. reflexivity. Qed.

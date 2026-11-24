(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Definition negb (b : bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1 : bool) (b2 : bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

(* `Check` command can query the type of an expression *)
Check true.
(** ==> true : bool **)
Check negb.
(** ==> negb : bool -> bool **)

(* `Check` command can also verify the type of an expression *)
Check true : bool.
(** ==> true : bool : bool **)

Check (negb true) : bool.
(** ==> negb true : bool : bool **)

(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

(* More complex inductive types - Constructors with arguments *)

Inductive rgb : Type :=
  | red
  | green
  | blue.

Inductive color : Type :=
  | black
  | white
  | primary (p : rgb). (* Complex constructor *)

(* Pattern matching for complex constructors *)
Definition monochrome (c : color) : bool :=
  match c with
  | black => true
  | white => true
  | primary p => false (* Complex constructor pattern *)
  end.

(* Deep pattern matching *)
Definition isred (c : color) : bool := 
  match c with
  | black => false
  | white => false
  | primary red => true (* Deep constructor pattern *)
  | primary _ => false (* Wildcard pattern to match all values *)
  end.

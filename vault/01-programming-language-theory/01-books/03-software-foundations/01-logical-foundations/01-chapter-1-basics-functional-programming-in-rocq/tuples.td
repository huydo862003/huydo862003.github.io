---
_type: PltBook
_label: 'Tuples: nybble datatype'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

Inductive bool : Type :=
  | true
  | false.

Module TuplePlayground.
  (* bit datatype that represents bool *)
  Inductive bit : Type :=
    | B1
    | B0.

  (* nybble datatype that represents half a byte *)
  Inductive nybble : Type :=
    | bits (b0 b1 b2 b3 : bit). (* Tuple definition *)

  Check (bits B1 B0 B1 B0) : nybble.

  (* Unwrap tuple *)
  Definition all_zero (nb : nybble) : bool :=
    match nb with
    | (bits B0 B0 B0 B0) => true
    | (bits _ _ _ _) => false
    end.

  Compute (all_zero (bits B1 B0 B1 B0)).
  (* ==> false : bool *)
  Compute (all_zero (bits B0 B0 B0 B0)).
  (* ==> true : bool *)
End TuplePlayground.
```

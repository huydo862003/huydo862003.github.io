---
_type: PltBook
_label: 'Days of the week: enumerated types and pattern matching'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

(* Enumerated data type - days of the week *)
Inductive day : Type :=
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday.
(** ==>
day is defined
day_rect is defined
day_ind is defined
day_rec is defined
day_sind is defined
**)

(* Pattern matching *)
(** The type signature is optional due to Rocq's ability to perform type inference - but it is included anyway to enhance readability **)
Definition next_working_day (d : day) : day :=
  match d with
  | monday => tuesday
  | tuesday => wednesday
  | wednesday => thursday
  | thursday => friday
  | friday => monday
  | saturday => monday
  | sunday => monday
  end.
(** ==> next_working_day is defined **)

(* Invoke a function using the `Compute` command *)
Compute (next_working_day friday).
(** ==> monday : day **)

Compute (next_working_day (next_working_day saturday)).
(** ==> tuesday : day **)

(* Record expectations using the `Example` command *)
Example test_next_working_day : (next_working_day (next_working_day saturday)) = tuesday.
(** ==> next_working_day (next_working_day saturday) = tuesday **)

Proof. simpl. reflexivity. Qed.
(** "The assertion we've just made can be proved by observing that both sides of the equality evaluate to the same thing." **)
```

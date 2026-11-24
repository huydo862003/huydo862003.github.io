---
_type: PltBook
_label: 'String import from standard library'
parent: fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

```coq
(* vim:ft=coq *)

(* `Require Export` statement to tell Rocq to use the String module from the standard library *)
From Stdlib Require Export String.
```

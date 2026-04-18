---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 4. an ML implementation of arithmetic expressions
author: Benjamin C. Pierce
date: ""
journey: plt
tags: []
concepts: []
parent: part-i-untyped-systems
children: []
---

- This introduces an implementation of our **language of booleans and arithmetic expressions**.
- The book's implementation code is written in **OCaml**, a popular language in the **ML family**. [Gordon, Milner, and Wadsworth, 1979; Leroy, 2000; Cousineau and Mauny, 1998]
- Only a **small subset** of OCaml is used, and the examples should be easy to translate to many other languages. [Leroy, 2000]
- The most important required features:
    - **Garbage collection** (automatic storage management).
    - **Pattern matching** to define **recursive functions** over structured data types. [Leroy, 2000]
- Other solid functional-language choices:
    - **Standard ML**, **Haskell**, and **Scheme** (with a pattern-matching extension). [Milner, Tofte, Harper, and MacQueen, 1997; Hudak et al., 1992; Thompson, 1999; Kelsey, Clinger, and Rees, 1998; Dybvig, 1996]
- Languages with garbage collection but without pattern matching (e.g., **Java** and plain Scheme) are **heavier** for this style of programming.
    
    Languages with neither (e.g., **C**) are even less suitable. [Arnold and Gosling, 1996; Kernighan and Ritchie, 1988]
    

# Summary
:::key
Keypoint 1: To distinguish between syntactic categories in evaluation rules, we use OCaml's pattern matching guards.
:::

# Source

[https://github.com/H-DNA/TAPL/tree/main/untyped_arithmetic_expressions](https://github.com/H-DNA/TAPL/tree/main/untyped_arithmetic_expressions)

# Implemented language

Operational semantics of boolean expressions

Operational semantics of arithmetic expressions - An extension of boolean expressions above

# Steps

## Terms definition

```ocaml
type term =
    TmTrue of info
  | TmFalse of info
  | TmIf of info * term * term * term
  | TmZero of info
  | TmSucc of info * term
  | TmPred of info * term
  | TmIsZero of info * term
```

- `TmTrue`, `TmFalse` are different sorts of nodes in the abstract syntax trees of type `term`.
- Each abstract syntax tree node is annotated with a value of type `info` (character position in which source file the node
originated). → Created by the parser.
    
    → For basic algorithms of evaluation and typechecking, etc., this information is irrelevant.
    

## Evaluation relation helpers

```ocaml
let rec isnumericval t = match t with
    TmZero(_) -> true
  | TmSucc(_, t1) -> isnumericval t1
  | _ -> false
```

The `rec` keyword tells the compiler that this is a recursive function definition-i.e., that the reference to `isnumericval` in its body refers to the function now being defined, rather than to some earlier binding with the same name.

```ocaml
let rec isval t = match t with
  | TmTrue(_) -> true
  | TmFalse(_) -> true
  | t when isnumericval t -> true
  | _ -> false
```

## Evaluation: Mirror the single-step evaluation rules.

- Analysis
    - If the evaluation function is applied to a value, **evaluation produces no further result** (i.e., no rule applies).
    - When translating the evaluation rules into OCaml, you must **choose how to represent this "stuck/no-step" case**.
    - A straightforward choice is to implement the single-step evaluator `eval1` so it **raises an exception** when **no evaluation rule applies** to the given term.
    - An alternative is for `eval1` to return a **`term option`**, where `None` means "no step possible" and `Some t'` means "successfully stepped to `t'`"; this also works but requires **extra bookkeeping**.

```ocaml
exception NoRulesApplied

let rec eval1 t = match t with
    TmIf(_, TmTrue(_), t2, t3) -> t2
  | TmIf(_, TmFalse(_), t2, t3) -> t3
  | TmIf(info, t1, t2, t3) -> 
    let t1' = eval1 t1 in
      TmIf(info, t1', t2, t3)
  | TmSucc(info, t1) ->
    let t1' = eval1 t1' in
      TmSucc(info, t1')
  | TmPred(_, TmZero(_)) -> TmZero(dummyinfo)
  | TmPred(_, TmSucc(_, nv1)) when isnumericval nv1 -> nv1
  | TmPred(info, t1) ->
    let t1' = eval1 t1 in
      TmPred(info, t1')
  | TmIsZero(_, TmZero(_)) -> TmTrue(dummyinfo)
  | TmIsZero(_, TmSucc(_, nv1)) when isnumericval nv1 -> TmFalse(dummyinfo)
  | TmIsZero(info, t1) ->
    let t1' = eval1 t1 in
      TmIsZero(info, t1')
  | _ -> raise NoRuleApplies
  
let rec eval t =
  try let t' = eval1 t
    in eval t'
  with NoRuleApplies -> t
```

- In several parts of the implementation, the evaluator **builds new terms from scratch** rather than just rearranging existing ones.
    
    Because these generated terms **don't correspond to any location in the user's original source file**, their **`info` annotations aren't meaningful/useful**.
    
    Therefore, the constant **`dummyinfo`** is used as the **placeholder `info` annotation** for such newly constructed terms.
    
- `eval1` uses **explicit `when` guards** in pattern matches to replicate the **implicit constraints** carried by metavariable names like `v` and `nv` in the formal evaluation rules.
    
    Example: in the case `TmPred(_, TmSucc(_, nv1))`, OCaml pattern matching would let `nv1` match **any term**, which is too permissive.
    
    Adding a guard like `when (isnumericval nv1)` ensures the rule **only fires when `nv1` is actually a numeric value**, matching the intended semantics.
    
    Equivalently, the formal inference rules could be rewritten to look more like ML patterns by turning those implicit metavariable constraints into **explicit side conditions**.
    
    - `eval` repeatedly applies `eval1`: whenever `eval1` produces a new term `t′`, `eval` **recursively continues** evaluation from `t′`.
    
    When `eval1` reaches a point where **no evaluation rule applies**, it raises the exception `NoRuleApplies`.
    
    Catching this exception causes `eval` to **stop iterating** and **return the last term reached**-the final result of the evaluation sequence.
    
- This evaluator is designed for **easy comparison with the formal (mathematical) definition of evaluation**, not for computing normal forms ***as fast as possible***.
    
    A **more efficient** approach could be built by starting from **big-step evaluation rules** (as in Exercise 4.2.2), rather than the current small-step style.
    

### Exercise 4.2.2

**Statement**. Change the definition of the `eval` function in the arith implementation to the big-step style introduced in Exercise 3.5.17.

<details>

<summary>Solution</summary>



```ocaml
let rec eval' t = match t with
TmIf(info, t1, t2, t3) ->
let t1' = eval' t1 in
match t1' with
TmTrue(_) -> eval' t2
| TmFalse(_) -> eval' t3
| _ -> t
| TmSucc(info, t1) ->
let t1' = eval' t1 in
match t1' with
_ when isnumericval t1' -> TmSucc(info, t1')
| _ -> t
| TmPred(info, t1) ->
let t1' = eval' t1 in
match t1' with
TmZero(info) -> TmZero(info)
| TmSucc(info, nv) when isnumericval nv -> nv
| _ -> t
| TmIsZero(info, t1) ->
let t1' = eval' t1 in
match t1' with
TmZero(_) -> TmTrue(dummyinfo)
| _ when isnumericval t1' -> TmFalse(dummyinfo)
| _ -> t
| _ -> t
```


</details>

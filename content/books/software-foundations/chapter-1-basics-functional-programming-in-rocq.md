---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Chapter 1. basics - functional programming in rocq"
author: Benjamin C. Pierce et al.
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - first-class-functional-programming-pure
  - rocq-gallina
  - rocq
  - function-rocq
  - enumerated-type
  - import-require
  - currying-rocq
  - infix
  - truthy-falsy-conditional-expression
  - rocq-truthy
  - rocq-axiom
  - rocq-inductive-definition
  - constructor-expression-constructor
  - wildcard-pattern-rocq
  - tuple-rocq
  - rocq-church-numeral
  - representation
  - church-numeral-rocq
  - rocq-constructor-function-computation-rule
  - fixed-point-combinator
  - recursive-type
  - proof-by-simplification
  - tactic
  - proof-by-rewriting
parent: logical-foundations
children: []
---

# Introduction

- The functional style of programming is founded on simple, everyday mathematical intuitions:
    
    > If a procedure or method has no side effects, then (ignoring efficiency) all we need to understand about it is how it maps inputs to outputs - that is, we can think of it as just a concrete method for computing a mathematical function.
    > 
    
    → One sense of the word "functional" in "functional programming".
    
    → The direct connection between **programs** and **simple mathematical objects** supports both **formal correctness proofs** and **sound informal reasoning** about program behavior.
    
    → Other sense of the word "functional": Emphasize the use of functions as First-class values.
    
- Other common features:
    - Algebraic data types.
    - Pattern matching.
    
    → Make it easy to construct and manipulate rich data structures.
    
    - Polymorphic type systems.
    
    → Support abstraction and code reuse.
    
- Rocq's native functional programming language: Gallina.
    
    Tactics are used to prove properties of Gallina programs.
    

# Data and functions

## Enumerated types

- Rocq has an extremely small set of built-in features.
    
    Example: Rocq offers a powerful mechanism to define booleans, integers, strings, etc. although they are also provided by the standard library.
    
- Example of an Enumerated type:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fc0fdaf2f596ff14476f1b8072b9cdb46011e2dc4%2Fsf%2Flf%2Fch01-basics%2Fdays-of-the-week.v%23L2-L19&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    Each case in the `day` definition is called a Constructor.
    
- Example of Pattern matching:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fc0fdaf2f596ff14476f1b8072b9cdb46011e2dc4%2Fsf%2Flf%2Fch01-basics%2Fdays-of-the-week.v%23L19-L33&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- Invoke a function:
    - Using the `Compute` command.
        
        <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F20ca195bc1b4e1b22c7b0c44771a33fca5219bfa%2Fsf%2Flf%2Fch01-basics%2Fdays-of-the-week.v%23L26-L31&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
        
        It seems that Type variants are visible in the global scope, unlike Rust.
        
    - Using the `Example` command.
        
        <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fe8f49c4be2e58cafb22c90d1e33f93a98757412a%2Fsf%2Flf%2Fch01-basics%2Fdays-of-the-week.v%23L41-L46&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
        
        - The `Example` command:
            - Define an assertion.
            - Give the assertion a name.
        - Use `Proof.` to ask Rocq to verify the example:
            
            > The assertion we've just made can be proved by observing that both sides of the equality evaluate to the same thing.
            > 
- We can ask Rocq to *extract*, from our `Definition`, a program in a more conventional programming language with a high-performance compiler.
    
    → Useful, since it gives us a path from proved-correct algorithms written in Gallina to efficient machine code.
    
- Import:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F3b13129df753edb8b271ff7e05e6486d833e863b%2Fsf%2Flf%2Fch01-basics%2Fstring-import.v%23L3-L4&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - `String` is a module in Rocq's terminology.

## Booleans

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fb6f189186d6591e77fcb0355e8875c386be0e39c%2Fsf%2Flf%2Fch01-basics%2Fbooleans.v%23L3-L23&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F4a0bf140d7c3fc86bc354ca63d3b5ba49e85a32b%2Fsf%2Flf%2Fch01-basics%2Fbooleans.v%23L25-L48&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

- Define infix notation using `Notation` command:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fe67c35727a6a641fe5ee03c4d469469e4ddafd53%2Fsf%2Flf%2Fch01-basics%2Fbooleans.v%23L50-L55&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- Conditional expressions using `if`/`then`/`else`:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F900980a061681e2019d35de3c4659162b6913601%2Fsf%2Flf%2Fch01-basics%2Fbooleans.v%23L57-L68&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    Notice that `bool` is not built-in in Rocq, so Rocq makes a generalization:
    
    - Conditional expressions over *any* **inductively defined type with exactly two clauses in its definition** are supported.
    - The guard is considered true if it evaluates to the "constructor" of the first clause of the Inductive definition.
- The command `Admitted` is used to **give up on the current proof and declare the initial goal as an axiom**, allowing the user to proceed without a formal proof.

### Exercise 1

**Problem statement**. The `Admitted` command can be used as a placeholder for an incomplete proof.  We use it in exercises to indicate the parts that we're leaving for you -- i.e., your job is to replace `Admitted`s with real proofs.

Remove "`Admitted.`" below and complete the definition of the following function; then make sure that the `Example` assertions below can each be verified by Rocq. (I.e., fill in each proof, following the model of the orb tests above, and make sure Rocq accepts it.) The function should return true if either or both of its inputs are false.

Hint: if `simpl` will not simplify the goal in your proof, it's probably because you defined `nandb` without using a match expression. Try a different definition of `nandb`, or just skip over `simpl` and go directly to `reflexivity`. We'll explain what's happening later in the chapter. 

```coq
Definition nandb (b1:bool) (b2:bool) : bool
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
Example test_nandb1:               (nandb true false) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb2:               (nandb false false) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb3:               (nandb false true) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb4:               (nandb true true) = false.
(* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F108bfc6b1806c69b700b9ee2d26d85352ff15741%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fnandb.v%23L11-L22&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### Exercise 2

**Problem statement.** Do the same for the `andb3` function below. This function should return `true` when all of its inputs are `true`, and `false` otherwise. 

```coq
Definition andb3 (b1:bool) (b2:bool) (b3:bool) : bool
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
Example test_andb31:                 (andb3 true true true) = true.
(* FILL IN HERE *) Admitted.
Example test_andb32:                 (andb3 false true true) = false.
(* FILL IN HERE *) Admitted.
Example test_andb33:                 (andb3 true false true) = false.
(* FILL IN HERE *) Admitted.
Example test_andb34:                 (andb3 true true false) = false.
(* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F108bfc6b1806c69b700b9ee2d26d85352ff15741%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fandb3.v%23L11-L22&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

## Types

- Every expression in Rocq has a type describing the sort of things it computes.
- The `Check` command can be used to extract the type of an expression:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F4df59248f432b30c8be4e41537c6e39a7b1bdee4%2Fsf%2Flf%2Fch01-basics%2Fcheck-command.v%23L25-L29&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    The type of `negb`, written `bool → bool` and pronounced "`bool` arrow `bool`". 
    
- The `Check` command can be used to verify the type of an expression matches the type after the colon.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F4df59248f432b30c8be4e41537c6e39a7b1bdee4%2Fsf%2Flf%2Fch01-basics%2Fcheck-command.v%23L31-L36&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    

## New types from old types

- A constructor of an Enumerated type can accept arguments:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F1a6504b9ee1f2b181ff37abe961105275db36002%2Fsf%2Flf%2Fch01-basics%2Fcolors.v%23L3-L11&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- An `Inductive` definition does two things:
    - It introduces a set of new *constructors.*
    - It groups them into a new named type.
- Constructor expressions are formed by applying a constructor to zero or more other constructors or constructor expressions, obeying the declared number and types of the constructor arguments.
- A constructor expression is said to belong to a specific **set**.
    
    Constructor expressions are the only way to construct members of the set.
    
- Pattern matching for complex constructors:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F016b30bad12b3a7354f808c7d8e7d2cd048c7860%2Fsf%2Flf%2Fch01-basics%2Fcolors.v%23L19-L25&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F016b30bad12b3a7354f808c7d8e7d2cd048c7860%2Fsf%2Flf%2Fch01-basics%2Fcolors.v%23L27-L34&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    `_` → Wildcard pattern.
    

## Modules

- In Rocq, theModule system helps organize large developments.
    - Declarations between `Module X` and `End X` markers are placed inside a module.
    - **Effect**: After `End`, definitions are accessed via `X.foo` instead of `foo`.
    
    → **Benefit**: Limits definition scope, allowing name reuse.
    

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fd39467543e1a1252f149bb5152dd1b06560f9a0d%2Fsf%2Flf%2Fch01-basics%2Fmodules.v%23L17-L28&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

## Tuples

- In Rocq, a **single constructor with multiple parameters** creates a tuple type.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F526d92a96d5b1876758b52554e4195256fbc2102%2Fsf%2Flf%2Fch01-basics%2Ftuples.v%23L4-L13&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    The constructor (e.g., `bits`) acts as a **wrapper** for tuple contents.
    
- **Unwrapping** is done via pattern-matching.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F2f4a419e5fd4ad7c0f67bbe44e048fe83f9d37d6%2Fsf%2Flf%2Fch01-basics%2Ftuples.v%23L19-L25&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    The underscore (`_`) here is a Wildcard pattern, which avoids inventing variable names that will not be used.
    

## Numbers

- In Rocq, Infinite type (like natural numbers) require richer type declarations than finite enumerated/tuple types.
- Many representations for numbers:
    - Decimal notation (base 10).
    - Hexadecimal notation (base 16).
    - Octal notation (base 8).
    - Binary notation (base 2).
    
    → Using an Enumerated type to represent the digits, we can use any of these.
    
- **Unary representation** (base 1) is simplest for proofs.
    
    This definition is a Recursive type.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F8d7a9c1d2da3b9a95d20e74742e49358c5cda162%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L3-L6&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    The base number: `O` - zero.
    
    The operation to build up: `S` - successor.
    
    → Church numeral.
    
    → What's special about the Church encoding of numbers and lists?
    
- This is just a Representation ****-constructor names are arbitrary.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Ff217e3e7fd34c01116aaa1df68eced3214069cca%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L8-L11&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - Example: `otherNat` with `stop` and `tick (foo : otherNat)` is equivalent.
    - Any `nat` is just some string of `S` marks followed by `O`.
    
    → The Interpretation of these marks arises from how we **compute** with them, not from the names themselves.
    
- Predecessor:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Ff217e3e7fd34c01116aaa1df68eced3214069cca%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L13-L18&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- Natural numbers in Rocq receive a special treatment for parsing & printing: Decimal numerals can be used instead of the unary notation.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Ff2164a3090fc0022d83daf1e456f037314310de8%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L21-L23&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- `S`, `pred`, and `minustwo` all have type `nat → nat`-they take a number and yield a number.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F7ff8cc5d1b358bcf77bc3cc1de781883929ef1ac%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L32-L35&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - **Fundamental difference**: constructors vs functions.
        - Functions (`pred`, `minustwo`) have Computation rules-e.g., `pred 2` simplifies to `1`.
        - Constructor `S` has **no computation behavior**-it just writes down numbers.
    - Analogy: the digit `1` in `111` isn't a computation; it's data representing a number.
    → `S` is a way of **writing** numbers; functions are ways of **computing** with them.
- Recursive function:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F8fbff2fb9f0578e7d3deed15ac0604122466527e%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L37-L50&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
- Pattern match multiple expressions with multiple patterns:
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F2893d955e4578d0643d5f9fc788c6dca44fa2961%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L71-L83&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    

### Exercise 3

**Problem statement.** Recall the standard mathematical factorial function:

$$
\begin{aligned}
\text{factorial}(0) & = &  1 \\
\text{factorial}(n) & = & n * \text{factorial}(n-1) & (if n>0)
\end{aligned}
$$

Translate this into Rocq.

Hint: Make sure you put a `:=` between the header we've provided and your definition. If you see an error like "The reference `factorial` was not found in the current environment," it means you've forgotten the `:=`. 

```coq
Fixpoint factorial (n:nat) : nat
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
Example test_factorial1:          (factorial 3) = 6.
(* FILL IN HERE *) Admitted.
Example test_factorial2:          (factorial 5) = (mult 10 12).
(* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fed6d94829633dd359aefa03d8e64fa309eb7ac2d%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Ffactorial.v%23L19-L24&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>




- Infix notation with user-defined associativity and precedence:

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F0c89f8ead961be0ca614dda2fe67bae7d7720f2d%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L85-L95&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

- Equality & [[**Boolean Blindness**](https://existentialtype.wordpress.com/2011/03/15/boolean-blindness/)]:

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fc78bd1b1e15c3771814dce7708dfe27b48f6d284%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L119-L123&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

Two symbols that look like equality: `=` and `=?`:

- `=`: A logical *claim* - a "proposition" - that we can try to prove.
- `=?`: A boolean *expression* whose value (either true or false) we can compute.

</details>

### Exercise 4

**Problem statement.** Fill in the definition of an `ltb` function that tests natural numbers for less-than, yielding a boolean.
Hint: Instead of making up a new `Fixpoint` for this one, define it in terms of a previously defined function. It can be done with just one previously defined function, but you can use two if you want.

```coq
Definition ltb (n m : nat) : bool
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
Notation "x <? y" := (ltb x y) (at level 70) : nat_scope.
Example test_ltb1:             (ltb 2 2) = false.
(* FILL IN HERE *) Admitted.
Example test_ltb2:             (ltb 2 4) = true.
(* FILL IN HERE *) Admitted.
Example test_ltb3:             (ltb 4 2) = false.
(* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



I use `Fixpoint` anyways.

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fe11447c12ed0d621c2108265a33fa08f7a1e7093%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fltb.v%23L2-L26&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

# Proof by simplification

- This section concerns itself with **stating and proving properties** about behaviors of datatypes & functions.
    - Previously, we specify the behavior of some functions on some particular inputs using `Example`.
    - The proofs of these claims:
        - Use `simpl` to simplify both sides of the claim.
        - Use `reflexivity` to check that both sides contain identical values.
            
            → Possibly refer to Reflexive.
            
        
        → Proof by simplification.
        
- A more interesting proof: `0` is a neutral element for `+` on the left.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fcfbef144b71ed24f9fa4c918bb8b5f15c8387389%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L134-L137&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - In the aforementioned examples, `simpl` was not actually required because `reflexivity` will do some simplification automatically when checking that two sides are equal.
        
        `simpl` was added so that we could see the intermediate state, after simplification but before finishing the proof.
        
        - Explanation
            - **Proof assistants are interactive** - you execute tactics one at a time and the IDE displays the current goal after each step
            - **Example with `simpl`**:
            
            ```coq
            Theorem plus_O_n : ∀ n : nat, 0 + n = n.
            Proof.
              intros n.
              (* IDE shows goal: 0 + n = n *)
              simpl.
              (* IDE shows goal: n = n *)
              reflexivity.
            Qed.
            
            ```
            
            - **Example without `simpl`**:
            
            ```coq
            Theorem plus_O_n : ∀ n : nat, 0 + n = n.
            Proof.
              intros n.
              (* IDE shows goal: 0 + n = n *)
              reflexivity.
              (* Proof completes immediately - you never see n = n *)
            Qed.
            
            ```
            
            - **Illustration of IDE state at each step**:
            
            | Step | Tactic | Goal displayed in IDE |
            | --- | --- | --- |
            | 1 | `intros n` | `0 + n = n` |
            | 2 | `simpl` | `n = n` |
            | 3 | `reflexivity` | proof complete, no goal |
            - **Without step 2** - you jump from `0 + n = n` directly to proof completion and never observe that `0 + n` simplifies to `n`
    - `reflexivity` actually performs more simplification than `simpl`.
        - **`simpl`** - computes expressions but avoids unfolding definitions; keeps the goal readable for continued work.
        - **`reflexivity`** - computes expressions and unfolds definitions; more aggressive because the proof ends immediately after.
        - Explanation
            - **`reflexivity` is more aggressive than `simpl`** - it performs additional simplification, including "unfolding" defined terms (replacing a name with its definition)
            - **What "unfolding" means**:
            
            ```coq
            Definition double (n : nat) := n + n.
            
            ```
            
            Unfolding `double 0` replaces it with `0 + 0` (the right-hand side of the definition).
            
            - **Why `reflexivity` can be aggressive** - if it succeeds, the proof is done; nobody needs to see or understand the messy expanded expression
            - **Why `simpl` is conservative** - you typically continue working after `simpl`, so you need the goal to remain readable; blindly expanding all definitions would create a cluttered, confusing goal
            - **Analogy** - `simpl` is like cleaning a room you'll keep using; `reflexivity` is like demolishing a room you're done with - neatness only matters if you have to stay
    - The keyword `Theorem` is synonymous with `Remark`, `Lemma`, `Fact` and `Example`.
    - `intros` tactic
        - **`∀ n:nat`** - a universal quantifier meaning "for all natural numbers n"
        - **Informal approach** - to prove such a theorem, you start by saying "suppose n is some number..."
        - **Formal approach** - the tactic `intros n` does this; it moves `n` from the quantifier in the goal to the context
        - **What is context** - a list of variables and assumptions currently available for use in the proof
        - **Example**:
        
        ```coq
        Theorem plus_O_n : ∀ n : nat, 0 + n = n.
        Proof.
          (* Context: (empty) *)
          (* Goal: ∀ n : nat, 0 + n = n *)
          intros n.
          (* Context: n : nat *)
          (* Goal: 0 + n = n *)
          reflexivity.
        Qed.
        
        ```
        
        | Step | Context | Goal |
        | --- | --- | --- |
        | Before `intros n` | (empty) | `∀ n : nat, 0 + n = n` |
        | After `intros n` | `n : nat` | `0 + n = n` |
        - **In short** - `intros n` says "let n be an arbitrary nat" and makes `n` available for the rest of the proof
- **Tactics** - commands used between `Proof` and `Qed` to guide the proof process; examples include `intros`, `simpl`, and `reflexivity`
- Another proof
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F77cc562769f10d85b9a6f62fe9e55488c7ad8797%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L139-L140&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - **Naming convention** - the `_l` suffix is pronounced "on the left," indicating which side of the operator is being discussed (e.g., `plus_1_l` is about adding 1 on the left)
    
    | Step | Context | Goal |
    | --- | --- | --- |
    | Start | (empty) | `∀ n:nat, 1 + n = S n` |
    | After `intros n` | `n : nat` | `1 + n = S n` |
    | After `simpl` | `n : nat` | `S n = S n` |
    | After `reflexivity` | proof complete | - |

# Proof by rewriting

- **New theorem structure** - instead of a universal claim, this theorem has a hypothesis (`n = m`) that must hold for the conclusion to follow.

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fd05ffee7c52c1cb63f86c41a07134260c675f0ad%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L145-L157&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

- **Arrow `→`** - pronounced "implies"; means if the left side is true, then the right side follows
- **`intros` can move multiple things into context** - both quantified variables and hypotheses.
- **New tactic: `rewrite`** - replaces one side of an equality with the other using a hypothesis.
    
    
    | Syntax | Meaning |
    | --- | --- |
    | `rewrite → H` | replace left with right (n → m) |
    | `rewrite ← H` | replace right with left (m → n) |
    | `rewrite H` | defaults to left-to-right |

| Step | Context | Goal |
| --- | --- | --- |
| Start | (empty) | `∀ n m:nat, n = m → n + n = m + m` |
| After `intros n m` | `n : nat, m : nat` | `n = m → n + n = m + m` |
| After `intros H` | `n : nat, m : nat, H : n = m` | `n + n = m + m` |
| After `rewrite → H` | `n : nat, m : nat, H : n = m` | `m + m = m + m` |
| After `reflexivity` | proof complete | - |

### Exercise 5

**Problem statement.** Remove `Admitted.` and fill in the proof.

Note: The theorem has two hypotheses (`n = m` and `m = o`), each to the left of an implication arrow.

```coq
Theorem plus_id_exercise : ∀ n m o : nat,
  n = m → m = o → n + m = m + o.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F651497d804f7d04941e4f62925240d606f8299ab%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fplus_id_exercise.v%23L3-L11&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>




- **`Admitted`** - tells Rocq to skip the proof and accept the theorem on faith.
- **Useful for** - developing longer proofs; you can state subsidiary lemmas, admit them temporarily, and continue working on the main argument.
- **Warning** - every `Admitted` leaves a door open for unproven (possibly false) claims to enter Rocq's verified world.
- The types of theorem

```coq
Check mult_n_O.
(* ===> forall n : nat, 0 = n * 0 *)

Check mult_n_Sm.
(* ===> forall n m : nat, n * m + n = n * S m *)
```

| Theorem | Type/Statement | Meaning |
| --- | --- | --- |
| `mult_n_O` | `forall n : nat, 0 = n * 0` | for any `n`, zero equals `n` times zero |
| `mult_n_Sm` | `forall n m : nat, n * m + n = n * S m` | for any `n` and `m`, `n * m + n` equals `n * (m + 1)` |

**In Rocq, theorems are types** - the statement is a type, and the proof is a value of that type.

- **`rewrite` can use previously proved theorems** - not just hypotheses from the current context
- **Rocq automatically fills in quantified variables** - it matches the theorem statement against the current goal to find appropriate values.
- **Example**:

```coq
Theorem mult_n_0_m_0 : ∀ p q : nat,
(p × 0) + (q × 0) = 0.
Proof.
intros p q.
rewrite <- mult_n_O.  (* uses theorem with n := p *)
rewrite <- mult_n_O.  (* uses theorem with n := q *)
reflexivity.
Qed.
```

| Step | Goal | Explanation |
| --- | --- | --- |
| After `intros p q` | `(p × 0) + (q × 0) = 0` | - |
| After first `rewrite <- mult_n_O` | `0 + (q × 0) = 0` | replaces `p × 0` with `0` |
| After second `rewrite <- mult_n_O` | `0 + 0 = 0` | replaces `q × 0` with `0` |
| After `reflexivity` | proof complete | `0 + 0` computes to `0`  |

**Why `rewrite <-` is used** - `mult_n_O` states `0 = n * 0`, so:

| Direction | Replaces | With |
| --- | --- | --- |
| `rewrite -> mult_n_O` | `0` | `n * 0` |
| `rewrite <- mult_n_O` | `n * 0` | `0` |

We want to simplify `n * 0` to `0`, so we use `rewrite <-`.


</details>

### Exercise 6

**Problem statement.** Use `mult_n_Sm` and `mult_n_O` to prove the following theorem. (Recall that `1` is `S O`.)

```jsx
Theorem mult_n_1 : ∀ p : nat,
  p × 1 = p.
Proof.
  (* FILL IN HERE *) Admitted. 
```

<details>

<summary>Proof</summary>


<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fa235d1344d214464c54ebf5cad2bc325a73ffd93%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fmult_n_1.v%23L3-L14&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>


</details>

# Proof by case analysis

- Not everything can be proved by simple calculation and rewriting.
    
    In general, unknown, hypothetical values can block simplification.
    
- The `Abort` command is used to give up on a proof.
    
    ```coq
    Theorem plus_1_neq_0_firsttry : forall n : nat,
    	(n + 1) =? 0 = false.
    Proof.
    	intros n.
    	simpl. (* does nothing *)
    Abort.
    ```
    
    In this case, `(n + 1)` fails to be simplified.
    
    Reason:
    
    - `+` and `eqb` begin by matching on their first arguments.
    - The first argument of `+` is the unknown `n`. → Cannot be simplified.
    - The first argument of `=?` is the compound expression `n + 1`. → Cannot be simplified.
    
    Consider the possible forms of `n`:
    
    - If `n` is `0`, the final result of `(n + 1) =? 0` can be calculated.
    - If `n = S n'` for some `n'`, then we can calculate that it will at least begin with one `S`. → Enough to know that `(n + 1) =? 0` is false.
- The `destruct` tactic can be used to tell Rocq to consider separate cases.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F07931b1b862991ee87daaa7cec4dad84d9295631%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L159-L167&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - **`destruct` generates subgoals** - one for each constructor of the datatype (e.g., `O` and `S` for `nat`).
    - **Intro pattern `as [| n']`** - specifies variable names for each subgoal:
        - Format: list of lists separated by `|` inside square brackets.
        - `[]` (empty) for `O` - it takes no arguments.
        - `[n']` for `S` - it takes one argument.
    - **Rocq tracks relevant assumptions** - in each subgoal, it remembers either `n = 0` or `n = S n'`.
    - **`eqn:E` annotation** - names the equation `E` for reference in the proof:
        - Without it, Rocq hides the assumption.
        - Keeping it is better practice for documentation and orientation.
    - **Bullets (`-`)** - mark proof sections corresponding to each subgoal:
        - Everything after a bullet is the proof for that subgoal.
        - Optional but strongly recommended.
        - If bullets are not present, Rocq simply expects to prove each subgoal in sequence, one at a time.
    - **Why use bullets**:
        - Makes proof structure visible and readable.
        - Ensures each subgoal is complete before moving on.
        - Prevents proofs from getting mixed up.
        - Especially important in larger developments to avoid long debugging sessions.
    - **No strict formatting rules in Rocq** - line breaks and indentation are flexible.
    - **Key guideline** - mark bullet points at the beginning of lines where multiple subgoals are generated; this ensures readability regardless of other layout choices.
    - **Line length advice** - avoid extremes:
        
        
        | Style | Problem |
        | --- | --- |
        | One tactic per line | Can be overly verbose |
        | Entire proof on one line | Hard to read |
        
        → Aim for 80 characters per line (or 120 if you have a wide screen or good eyes).
        
- The `destruct` tactic can be used  with any inductively defined datatype.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Ff6ffc12e6a19328c5a06aa1210ffd97995b693f3%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L169-L177&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    - **`as` clause can be omitted** - when no variables need to be bound in subcases.
    - **Rocq will auto-generate names** - if `as` clause is omitted entirely.
    - **This is bad style** - Rocq often chooses confusing names; always specify names explicitly for clarity.
- `destruct` can itself be used within a subgoal.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Ff6ffc12e6a19328c5a06aa1210ffd97995b693f3%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L179-L191&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    Different bullet symbols mark different levels.
    
    | Symbol | Variants |
    | --- | --- |
    | `-` | `--`, `---`, etc. |
    | `+` | `++`, `+++`, etc. |
    | `*` | `**`, `***`, etc. |
- **Alternative: curly braces** - can enclose sub-proofs instead of bullets.
    
    <iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F9886198e747ba799937c6e9db7df3b7eca19e13c%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L193-L204&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
    
    **Advantage of curly braces** - they mark both beginning and end, so:
    
    - Can be used for multiple levels
    - Allow reusing the same bullet shapes at different levels

### Exercise 7

**Problem statement.** Prove the following claim, marking cases (and subcases) with bullets when you use `destruct`.

```coq
Theorem andb_true_elim2 : ∀ b c : bool,
  andb b c = true → c = true.
Proof.
  (* FILL IN HERE *)
Admitted.
```

**Hints**:

- **Hint 1**: `simpl` can simplify hypotheses, not just the goal - use `simpl in H` where `H` is a hypothesis.
- **Hint 2**: You will need to `destruct` both booleans; simplify the hypothesis before destructing the second boolean.
- **Hint 3**: If you reach a contradiction in the hypotheses, use `rewrite` with that contradiction.
<details>
<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F8760cd75507509b9a5e0725b06189273c50487d2%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fandb_true_elim2.v%23L3-L13&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>




- **Common pattern** - introducing a variable then immediately destructing it:

```coq
intros x y. destruct y as [|y] eqn:E.
```

→ Shorthand: Use an intro pattern directly with `intros` to combine both steps:

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F7e0e2a77e8c0ccc6719500818ebd036344dd7bd3%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L207-L213&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

**Downside:** you lose the `eqn:E` equation that records which case you're in.

- **Empty brackets** - use when constructors take no arguments:

<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F7e0e2a77e8c0ccc6719500818ebd036344dd7bd3%2Fsf%2Flf%2Fch01-basics%2Fnumbers.v%23L215-L223&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>


| Syntax | Meaning |
| --- | --- |
| `intros []` | introduce and destruct; no arguments to name |
| `intros [] []` | destruct multiple variables at once |

</details>

### Exercise 8

**Problem statement.** 

```coq
Theorem zero_nbeq_plus_1 : ∀ n : nat,
  0 =? (n + 1) = false.
Proof.
  (* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F7b6602ec6cff67bd3eec6865baec35df4600b9ce%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fzero_nbeq_plus_1.v%23L3-L9&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

# **More on notation (Optional)**

- **Notation definitions** for infix operators:

```coq
Notation "x + y" := (plus x y)
                    (at level 50, left associativity)
                    : nat_scope.
Notation "x * y" := (mult x y)
                    (at level 40, left associativity)
                    : nat_scope.
```

- **Precedence level** - specified by `at level n` (0 to 100); helps Rocq parse compound expressions.
- **Associativity** - can be `left`, `right`, or none; disambiguates repeated operators.
- **Example**: `1+2*3*4` parses as `(1+((2*3)*4))` because:
    - has level 40 (higher precedence than `+` at level 50).
    - Both are left associative.
- **Notation scopes** - each symbol is associated with a scope:
    - Rocq guesses from context (e.g., `nat_scope` for `S(O*O)`)
    - Can be explicit: `(x*y)%nat`
    - Numerals also have scopes: `0%nat` means `O`, `0%Z` means integer zero.
- **Pro tip**: Rocq's notation mechanism is not especially powerful; don't expect too much from it.

# **Fixpoints and Structural Recursion (Optional)**

- **Example definition**:

```coq
Fixpoint plus' (n : nat) (m : nat) : nat :=
  match n with
  | O ⇒ m
  | S n' ⇒ S (plus' n' m)
  end.
```

- **Structural recursion** - Rocq notes that `plus'` is "decreasing on 1st argument".
    - Recursive calls only on strictly smaller values of `n`.
    - Guarantees all calls will eventually terminate.
- **Rocq requirement** - some argument of every `Fixpoint` must be "decreasing".
- **Why this matters** - guarantees every Rocq function terminates on all inputs.
- **Limitation** - Rocq's "decreasing analysis" is not very sophisticated, so sometimes functions must be written in slightly unnatural ways.

### Exercise 9

**Problem statement.** Find a way to write a sensible `Fixpoint` definition (of a simple function on numbers, say) that does terminate on all inputs, but that Rocq will reject because of the "decreasing argument" restriction.

*Note: If you submit this as homework, comment out your solution so it doesn't cause Rocq to reject the whole file.*

```coq
(* FILL IN HERE *)
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fd4ac91e4654d5880b63e358618e772b64fe51835%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fnon_decreasing_strongly_normalizing_fixpoint.v%23L36-L42&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

# More exercises

## Warmups

### **Exercise 10**

**Problem statement.** Use the tactics you have learned so far to prove the following theorem about boolean functions.

```coq
Theorem identity_fn_applied_twice :
  ∀ (f : bool → bool),
  (∀ (x : bool), f x = x) →
  ∀ (b : bool), f (f b) = b.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2F570d908548585fdea4d156e11be1a86e9b4adef2%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fidentity_fn_applied_twice.v%23L3-L14&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 11**

**Problem statement.** Now state and prove a theorem `negation_fn_applied_twice` similar to the previous one but where the hypothesis says that the function `f` has the property that `f x = negb x`.

```coq
(* FILL IN HERE *)

(* Do not modify the following line: *)
Definition manual_grade_for_negation_fn_applied_twice : option (nat×string) := None.
```

*(The last definition is used by the autograder.)*

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fa1bff03b22f0bd60830d9ba4561b88088c157a7a%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fnegation_fn_applied_twice.v%23L3-L16&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 12**

**Problem statement.** Prove the following theorem.

*Hint: This can be tricky depending on your approach. You will probably need both `destruct` and `rewrite`, but destructing everything in sight is not the best way.*

```coq
Theorem andb_eq_orb :
  ∀ (b c : bool),
  (andb b c = orb b c) →
  b = c.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2FH-DNA%2Ftype-theory%2Fblob%2Fd01440304fe918fbdaf98c8302086b7f30a396df%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fandb_eq_orb.v%23L3-L17&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

## Course Late Policies, Formalized

Suppose a course has a grading policy based on late days, where a student's final letter grade is lowered if they submit too many homework assignments late.

In the next series of problems, we model this situation and prove some simple facts about this grading policy.

```coq
Module LateDays.
```

**Letter grades**:

```coq
Inductive letter : Type :=
  | A | B | C | D | F.
```

**Grade modifiers** - a `Natural` A is just a "plain" grade of A:

```coq
Inductive modifier : Type :=
  | Plus | Natural | Minus.
```

**Full grade** - a letter and a modifier (e.g., "A-" is `Grade A Minus`, "C" is `Grade C Natural`):

```coq
Inductive grade : Type :=
  Grade (l:letter) (m:modifier).
```

**Comparison datatype** - more informative than boolean comparisons:

```coq
Inductive comparison : Type :=
  | Eq   (* "equal" *)
  | Lt   (* "less than" *)
  | Gt.  (* "greater than" *)
```

**Letter comparison** - uses pattern matching with two features:

- **Simultaneous matching**: `match l1, l2 with` is shorthand for nested matching
- **Multiple possibilities**: `C, (A | B)` stands for both `C, A` and `C, B`

```coq
Definition letter_comparison (l1 l2 : letter) : comparison :=
  match l1, l2 with
  | A, A ⇒ Eq
  | A, _ ⇒ Gt
  | B, A ⇒ Lt
  | B, B ⇒ Eq
  | B, _ ⇒ Gt
  | C, (A | B) ⇒ Lt
  | C, C ⇒ Eq
  | C, _ ⇒ Gt
  | D, (A | B | C) ⇒ Lt
  | D, D ⇒ Eq
  | D, _ ⇒ Gt
  | F, (A | B | C | D) ⇒ Lt
  | F, F ⇒ Eq
  end.
```

**Testing**:

```coq
Compute letter_comparison B A.   (* ==> Lt *)
Compute letter_comparison D D.   (* ==> Eq *)
Compute letter_comparison B F.   (* ==> Gt *)
```

### **Exercise 13**

**Problem statement.** Prove that comparing a letter against itself gives `Eq`.

```coq
Theorem letter_comparison_Eq :
  ∀ l, letter_comparison l l = Eq.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fhdnax%2Ftype-theory%2Fblob%2F6d881edd4a09a28f65c6c9801bd95c16abd6c5a9%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fcourse_late_policies.v%23L36-L48&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 14**

**Modifier comparison** - ordered as `Plus > Natural > Minus`:

```coq
Definition modifier_comparison (m1 m2 : modifier) : comparison :=
  match m1, m2 with
  | Plus, Plus ⇒ Eq
  | Plus, _ ⇒ Gt
  | Natural, Plus ⇒ Lt
  | Natural, Natural ⇒ Eq
  | Natural, _ ⇒ Gt
  | Minus, (Plus | Natural) ⇒ Lt
  | Minus, Minus ⇒ Eq
  end.
```

**Problem statement.** Use pattern matching to complete the definition.

*This uses lexicographic ordering: compare letters first, then modifiers only if letters are equal. All grade variants of A are greater than all grade variants of B.*

*Hint: Match against `g1` and `g2` simultaneously, but do case analysis on the result of `letter_comparison` to get just 3 possibilities.*

```coq
Definition grade_comparison (g1 g2 : grade) : comparison
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
```

**Unit tests**:

```coq
Example test_grade_comparison1 :
  (grade_comparison (Grade A Minus) (Grade B Plus)) = Gt.
(* FILL IN HERE *) Admitted.

Example test_grade_comparison2 :
  (grade_comparison (Grade A Minus) (Grade A Plus)) = Lt.
(* FILL IN HERE *) Admitted.

Example test_grade_comparison3 :
  (grade_comparison (Grade F Plus) (Grade F Plus)) = Eq.
(* FILL IN HERE *) Admitted.

Example test_grade_comparison4 :
  (grade_comparison (Grade B Minus) (Grade C Plus)) = Gt.
(* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fhdnax%2Ftype-theory%2Fblob%2F998a92c46194ab2944755663cf5ea10d53ec64fc%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fcourse_late_policies.v%23L61-L94&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 15**

**Lowering a letter grade** - F stays as F:

```coq
Definition lower_letter (l : letter) : letter :=
  match l with
  | A ⇒ B
  | B ⇒ C
  | C ⇒ D
  | D ⇒ E
  | E => F
  | F ⇒ F  (* Can't go lower than F! *)
  end.
```

**Edge case insight** - the naive theorem fails because lowering F gives F, not something lower:

```coq
Theorem lower_letter_F_is_F:
  lower_letter F = F.
Proof.
  simpl. reflexivity.
Qed.
```

**Problem statement.** Prove the corrected theorem - as long as `l` is greater than F, lowering it produces a lower letter.

```coq
Theorem lower_letter_lowers:
  ∀ (l : letter),
    letter_comparison F l = Lt →
    letter_comparison (lower_letter l) l = Lt.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fhdnax%2Ftype-theory%2Fblob%2F92a555a91de9b985c3710aeaf5b6b20b873b54b2%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fcourse_late_policies.v%23L96-L129&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 16**

**Problem statement.** Complete the definition to lower a grade by one step (unless already `Grade F Minus`).

*Hint: Use nested pattern matching. The outer match should only consider the modifier, not the letter. Don't enumerate all cases.*

```coq
Definition lower_grade (g : grade) : grade
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
```

**Unit tests**:

```coq
Example lower_grade_A_Plus :
  lower_grade (Grade A Plus) = (Grade A Natural).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_A_Natural :
  lower_grade (Grade A Natural) = (Grade A Minus).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_A_Minus :
  lower_grade (Grade A Minus) = (Grade B Plus).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_B_Plus :
  lower_grade (Grade B Plus) = (Grade B Natural).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_F_Natural :
  lower_grade (Grade F Natural) = (Grade F Minus).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_twice :
  lower_grade (lower_grade (Grade B Minus)) = (Grade C Natural).
Proof. (* FILL IN HERE *) Admitted.

Example lower_grade_thrice :
  lower_grade (lower_grade (lower_grade (Grade B Minus))) = (Grade C Minus).
Proof. (* FILL IN HERE *) Admitted.

Theorem lower_grade_F_Minus :
  lower_grade (Grade F Minus) = (Grade F Minus).
Proof. (* FILL IN HERE *) Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fhdnax%2Ftype-theory%2Fblob%2F00bf2d1621910ddfe35faf0317cc2bde1f760021%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fcourse_late_policies.v%23L131-L140&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>
</details>

### **Exercise 17**

**Problem statement.** Prove that, as long as the grade is above F-, `lower_grade` does lower the grade.

*Hint: If you defined `grade_comparison` as suggested, you only need to destruct a letter in one case. The F case will benefit from `lower_grade_F_Minus`.*

```coq
Theorem lower_grade_lowers :
  ∀ (g : grade),
    grade_comparison (Grade F Minus) g = Lt →
    grade_comparison (lower_grade g) g = Lt.
Proof.
  (* FILL IN HERE *)
Admitted.
```

<details>

<summary>Solution</summary>



<iframe src="https://emgithub.com/iframe.html?target=https%3A%2F%2Fgithub.com%2Fhdnax%2Ftype-theory%2Fblob%2F00bf2d1621910ddfe35faf0317cc2bde1f760021%2Fsf%2Flf%2Fch01-basics%2Fexercises%2Fcourse_late_policies.v%23L174-L204&style=default&type=code&showBorder=on&showLineNumbers=on&showFileMeta=on&showCopy=on" style="width:100%; height:auto; min-height:100px; border:0;" loading="lazy"></iframe>

- Learning points

My `lower_grade` function mixed specific and general patterns at the same level:

```coq
Definition lower_grade (g : grade) : grade :=
match g with
| Grade m Plus => Grade m Natural
| Grade m Natural => Grade m Minus
| Grade F Minus => g                      (* specific *)
| Grade m Minus => Grade (lower_letter m) Plus  (* general *)
end.
```

When proving theorems, `simpl` produced weird residual matches like `match l with | A | _ => ... end` even for the `Plus` case, blocking simplification.

The cause: Coq saw `F` mentioned in the patterns and couldn't simplify with an abstract letter variable `l`-it worried `l` might be `F`.

The fix: Use nested matching to isolate the specific case:

```coq
Definition lower_grade (g : grade) : grade :=
match g with
| Grade l Plus => Grade l Natural
| Grade l Natural => Grade l Minus
| Grade l Minus => match l with
| F => g
| _ => Grade (lower_letter l) Plus
end
end.
```

- Takeaways
1. Pattern structure affects proofs, not just runtime behavior.
2. Mixing specific and general patterns at the same level causes trouble with abstract variables.
3. Nested matching isolates specificity-each level stays orthogonal.
4. Symptom to watch for: residual matches after `simpl` where all branches are identical.
5. Both definitions compute the same results-nesting just helps Coq simplify during proofs.



</details>

### **Exercise 18**

**Late policy implementation**:

| Late days | Penalty |
| --- | --- |
| 0 - 8 | no penalty |
| 9 - 16 | lower by one step |
| 17 - 20 | lower by two steps |
| ≥ 21 | lower by three steps |

```coq
Definition apply_late_policy (late_days : nat) (g : grade) : grade :=
  if late_days <? 9 then g
  else if late_days <? 17 then lower_grade g
  else if late_days <? 21 then lower_grade (lower_grade g)
  else lower_grade (lower_grade (lower_grade g)).
```

**Unfold theorem** - useful for rewriting:

```coq
Theorem apply_late_policy_unfold :
  ∀ (late_days : nat) (g : grade),
    (apply_late_policy late_days g)
    =
    (if late_days <? 9 then g else
       if late_days <? 17 then lower_grade g
       else if late_days <? 21 then lower_grade (lower_grade g)
            else lower_grade (lower_grade (lower_grade g))).
Proof.
  intros. reflexivity.
Qed.
```

**Problem statement.** If a student has no more than 8 late days, their grade is unaffected.

```coq
Theorem no_penalty_for_mostly_on_time :
  ∀ (late_days : nat) (g : grade),
    (late_days <? 9 = true) →
    apply_late_policy late_days g = g.
Proof.
  (* FILL IN HERE *)
Admitted.
```

### **Exercise 19**

**Problem statement.** If a student has between 9 and 16 late days, their grade is lowered by one step.

```coq
Theorem grade_lowered_once :
  ∀ (late_days : nat) (g : grade),
    (late_days <? 9 = false) →
    (late_days <? 17 = true) →
    (apply_late_policy late_days g) = (lower_grade g).
Proof.
  (* FILL IN HERE *)
Admitted.
```

```coq
End LateDays.
```

## Binary Numerals

### **Exercise 20**

**Problem statement.** We can generalize unary representation to binary by treating a binary number as a sequence of `B0` and `B1` constructors terminated by `Z`.

| Decimal | Binary | Unary |
| --- | --- | --- |
| 0 | `Z` | `O` |
| 1 | `B1 Z` | `S O` |
| 2 | `B0 (B1 Z)` | `S (S O)` |
| 3 | `B1 (B1 Z)` | `S (S (S O))` |
| 4 | `B0 (B0 (B1 Z))` | `S (S (S (S O)))` |
| 5 | `B1 (B0 (B1 Z))` | `S (S (S (S (S O))))` |
| 6 | `B0 (B1 (B1 Z))` | `S (S (S (S (S (S O)))))` |
| 7 | `B1 (B1 (B1 Z))` | `S (S (S (S (S (S (S O))))))` |
| 8 | `B0 (B0 (B0 (B1 Z)))` | `S (S (S (S (S (S (S (S O)))))))` |

*Note: Low-order bit is on the left, high-order bit on the right (opposite of usual notation). This makes manipulation easier.*

*Comprehension check: What unary numeral does `B0 Z` represent?*

```coq
Inductive bin : Type :=
  | Z
  | B0 (n : bin)
  | B1 (n : bin).
```

**Complete the definitions**:

```coq
Fixpoint incr (m:bin) : bin
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.

Fixpoint bin_to_nat (m:bin) : nat
  (* REPLACE THIS LINE WITH ":= _your_definition_ ." *). Admitted.
```

**Unit tests**:

```coq
Example test_bin_incr1 : (incr (B1 Z)) = B0 (B1 Z).
(* FILL IN HERE *) Admitted.

Example test_bin_incr2 : (incr (B0 (B1 Z))) = B1 (B1 Z).
(* FILL IN HERE *) Admitted.

Example test_bin_incr3 : (incr (B1 (B1 Z))) = B0 (B0 (B1 Z)).
(* FILL IN HERE *) Admitted.

Example test_bin_incr4 : bin_to_nat (B0 (B1 Z)) = 2.
(* FILL IN HERE *) Admitted.

Example test_bin_incr5 :
        bin_to_nat (incr (B1 Z)) = 1 + bin_to_nat (B1 Z).
(* FILL IN HERE *) Admitted.

Example test_bin_incr6 :
        bin_to_nat (incr (incr (B1 Z))) = 2 + bin_to_nat (B1 Z).
(* FILL IN HERE *) Admitted.

Example test_bin_incr7 : bin_to_nat (B0 (B0 (B0 (B1 Z)))) = 8.
(* FILL IN HERE *) Admitted.
```

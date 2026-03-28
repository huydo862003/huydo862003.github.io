---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 2. Evaluation
author: Shriram Krishnamurthi
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - evaluator
  - compiler-interpreter
  - evaluator-interpreter
  - just-in-time-jit-compilation
  - read-eval-print-loop-repl
  - read-eval-print-loop-repl-compiler-interpreter
  - conditional-expression
parent: programming-languages-application-and-interpretation
children: []
---

# Overview

- This document covers **SImPl** (Standard Implementation Plan) - a systematic approach to building programming language Evaluators.
- The core idea:
    1. Represent programs as data.
    2. Write programs that process that data.

# Evaluation on Paper

## Two kinds of Evaluators

- An **evaluator** reduces programs to values.
- There are two fundamental strategies:
    - **Interpreter**:
        - Directly simulate program execution.
        - Take a program, produces a value.
    - **Compiler**:
        - Transform a program into another program in a **target language**.
        - That output must then be evaluated further (interpreted or compiled again).
    - **Hybrid** systems combine both.
        
        Example: **JIT (Just-In-Time) compilation** starts interpreting, then compiles frequently-used code.
:::tip
The phrase "**interpreted language**" or "**compiled language**" is meaningless. Languages do not mandate implementation strategy - implementers choose freely.
:::

A **REPL** (Read-Eval-Print Loop) is just an interactive interface; it reveals nothing about underlying implementation.

# Simulating evaluation by hand

- When a function is called:
    - **Formal parameter**s: The variable names declared in the function definition.
    - Actual parameter/Arguments: The expressions passed at the call site.
- **Evaluation strategy** determines when arguments are evaluated:
    - Strict/Eager evaluation strategy: Evaluate arguments to values before entering the function body. SMoL uses this.
    - Lazy evaluation strategy: Defer argument evaluation until the value is actually needed.
- **Evaluation order** determines sequencing:
    - Sequential evaluation: Finish one computation before starting another.
    - **Parallel evaluation**: Evaluate multiple expressions simultaneously.
    - SMoL uses sequential, left-to-right order.

# Representing programs

## Surface syntax vs abstract syntax

- Concrete/Surface syntax: The textual form programmers write.
    - Examples: `1 + 2`, `(+ 1 2)`, visual blocks in Scratch.
    - Important for human factors but distracting when studying language semantics.
- Structural/Abstract syntax: The essential structure of a program, stripped of superficial details.
:::tip
Multiple Concrete/Surface syntaxes can map to identical Structural/Abstract syntax.
:::

## Abstract syntax trees

- [Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast): A tree-structured data representation of abstract syntax.
    
    → Analogous to Sentence diagram in linguistics - turning linear text into hierarchical structure.
    

```racket
#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [plusE (left : Exp) (right : Exp)])
```

- Key properties:
    - Ambiguity (like operator precedence) must be resolved before AST construction.
    - Operations become **constructor** names, not parameters.
    - The AST ignores which Concrete/Surface syntax was used.
:::tip
[Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast)s let us **represent programs in programs**.
:::

→ Builds on foundational work by:

- Gödel (encoding).
- Turing (universal machine).
- von Neumann (stored program computer).
- McCarthy (metacircular interpreter).

# Evaluating arithmetic

## The calculator

```racket
#lang plai-typed

(define (calc e) 
  (type-case Exp e
    [numE (n) n]
    [plusE (l r) (+ (calc l) (calc r))]))
```

- Type signature: `Exp -> Number`.
- The evaluator pattern-matches on AST constructors:
    - For **`num`**: Return the wrapped number directly.
    - For **`plus`**: Recursively evaluate both sub-expressions, then add results.
- By using the Host language's primitives (like `+`), we inherit its semantics.
    - Pros: Powerful (reuse existing functionality).
    - Cons: Dangerous (we might accidentally adopt unwanted behavior like floating-point quirks).

# Parsing

- Parsing: Converting Concrete/Surface syntax into [Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast)s.
- S-expression/Symbolic expression: A parenthetical syntax providing a balance between human convenience and implementation simplicity.
- SImPl picks a Concrete/Surface syntax that is **S-expression/Symbolic expression**:
    - Strike a reasonable balance between **convenience and simplicity**.
    - Have special support in The Plait programming language.
    - Made convenient to work with in Racket.
    
    ```racket
    1
    (+ 1 2)
    (+ 1 (+ 2 3))
    ```
    
- Convention (that Racket doesn't care about, because it treats `()`, `[]`, and `{}` interchangeably): **Programs are represented using `{}` instead of `()`.**
    
    ```racket
    1
    {+ 1 2}
    {+ 1 {+ 2 3}}
    ```
    
- In The Plait programming language:
    - A special data type `s-expression`.
    - A value of this data type is preceded by a **back-tick**.
    
    ```racket
    #lang plai-typed
    
    `1 ; number s-expression
    `{1 + 2} ; list s-expression
    `+ ; symbol
    ```
    
- In The Plait programming language, to check the specific kind of an `s-expression`:
    
    ```racket
    #lang plai-typed
    
    > (s-exp-number? `1)
    - boolean
    #t
    
    > (s-exp-list? `{1 + 2})
    - boolean
    #t
    
    > (s-exp-symbol? `+)
    - boolean
    #t
    ```
    
- The `s-expression` values are wrappers around the actual data, this data can be accessed by:
    
    ```racket
    #lang plai-typed
    
    > (s-exp->number `1)
    - number
    1
    
    > (s-exp->list `{+ 1 2})
    - (listof s-expression)
    '(+ 1 2)
    
    > (s-exp->symbol `+)
    - symbol
    '+
    ```
    

## Parser structure

```racket
#lang plai-typed

(define (parse [s : s-expression]) : Exp
  (cond
    [(s-exp-number? s) (numE (s-exp->number s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (cond
         [(not (= (length l) 3)) (error 'parse "Expect 3 terms in subexpression")]
         [(not (s-exp-symbol? (first l))) (error 'parse "Expect a symbol as the first term")]
         [(not (symbol=? '+ (s-exp->symbol (first l))))
               (error 'parse "Expect +")]
         [else
          (plusE (parse (second l))
                 (parse (third l)))]))]))
```

- A parser:
    - Check s-expression type.
    - Extract components.
    - Recursively build AST nodes.
    - Error handling catches malformed input.
- Test cases:
    
    ```racket
    #lang plai-typed
    
    ; Positive tests
    (test (parse `1) (num 1))
    (test (parse `2.3) (num 2.3))
    (test (parse `{+ 1 2}) (plus (num 1) (num 2)))
    
    ; Negative tests
    (test/exn (parse `{1 + 2}) "Expect a symbol as the first term")
    ```
    
- The parser composes with the evaluator: `run = calc ∘ parse`.

# Evaluating conditionals

Add conditionals to the current `parse` function: An `if` expression with 3 parts - condition, `then` branch and `else` branch.

**Design space** - Even simple conditionals require multiple design decisions:

- **Test expression values**: What can appear in the condition?
    - **Strict approach**: Must be Boolean.
    - **Permissive approach**: Allow **truthy/falsy** values. Different languages disagree wildly on which values are falsy (0, empty string, null, empty list, etc.).
    - Scheme's elegant compromise: Only `#false` is falsy; everything else is truthy.
- **Branch types**: Are branches statements (no return value) or expressions (produce values)?
    - Some languages allow 2 syntactic forms: Ternary operator (for expressions) and `if` (for statements).
- **Branch value agreement**: Must both branches produce the same type?

```racket
#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [boolE (b : boolean)]
  [plusE (left : Exp) (right : Exp)]
  [condE (test : Exp) (then : Exp) (else : Exp)])

(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)])

(define (parse [s : s-expression]) : Exp
  (cond
    [(s-exp-number? s) (numE (s-exp->number s))]
    [(s-exp-boolean? s) (boolE (s-exp->boolean s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (if (= (length l) 0)
           (error 'parse "Unexpected empty s-expression")
           (let ([op (first l)]
                 [args-len (- (length l) 1)])
             (if (not (s-exp-symbol? op))
                 (error 'parse "Unexpected operator")
                 (let ([op (s-exp->symbol op)])
                   (cond
                     [(symbol=? '+ op)
                      (if (not (= args-len 2))
                          (error '+ "Expect 2 arguments")
                          (plusE (parse (second l))
                                 (parse (third l))))]
                     [(symbol=? 'cond op)
                      (if (not (= args-len 3))
                          (error 'cond "Expect 3 arguments")
                          (condE (parse (second l))
                                 (parse (third l))
                                 (parse (list-ref l 3))))]
                     [else (error 'parse "Unexpected operator")]))))))]))

(define (add v1 v2)
  (type-case Value v1
    [numV (n1)
     (type-case Value v2
       [numV (n2) (numV (+ n1 n2))]
       [else (error '+ "Expect RHS to be a number")])]
    [else (error '+ "Expect LHS to be a number")]))

(define (boolean-decision v)
  (type-case Value v
    [boolV (b) b]
    [else (error 'if "Expect conditional to evaluate to a boolean")]))

(define (calc [e : Exp]) : Value 
  (type-case Exp e
    [numE (n) (numV n)]
    [boolE (b) (boolV b)]
    [plusE (l r) (add (calc l) (calc r))]
    [condE (c t e) (if (boolean-decision (calc c))
                      (calc t)
                      (calc e))]))

(define (run [s : s-expression]) : Value
  (calc (parse s)))
```

## Evaluating local binding

- Binding: Associating a name with a value.
- Scope : The region of a program where a binding is visible.
- **Local binding**: A binding limited to a specific scope.
- Shadowing: An inner binding temporarily hides an outer binding of the same name.

### The problem with conventional syntax

Many languages have ambiguous scope boundaries:

```python
def f(x):
    for y in range(10):
        print(x + y)
    y  # Is y still in scope here?

```

Whether `y` is still bound after the loop depends on language-specific rules. This is complicated and often unintuitive.

**Parenthetical syntax** solves this by making scope boundaries explicit - the binding is visible only between the parentheses/braces.

### Syntax for local binding

BNF grammar:

```bnf
<expr> ::= <num>
         | {+ <expr> <expr>}
         | {let1 {<var> <expr>} <expr>}
         | <var>
```

- The **`let1`** construct has three parts: a **variable name**, a **value expression**, and a **body expression**.
- The **`var`** production allows variable usage. Without this, we can bind but not use variables.
- The first `<expr>` in let1 is evaluated and bound to `<var>`.
- The second `<expr>` is the body where the binding is visible.

### The meaning of local binding

Examples demonstrating expected behavior:

```scheme
{let1 {x 1}
  {+ x x}}
;; => 2

{let1 {x 1}
  {let1 {y 2}
    {+ x y}}}
;; => 3

{let1 {x 1}
  {let1 {y 2}
    {let1 {x 3}
      {+ x y}}}}
;; => 5 (inner x shadows outer x)

{let1 {x 1}
  {+ x
     {let1 {x 2} x}}}
;; => 3 (left x is 1, right x is shadowed to 2)

{let1 {x 1}
  {+ {let1 {x 2} x}
     x}}
;; => 3 (left evaluates to 2, right x is still 1)

x
;; => error: x is not bound (syntax error)

```

**Key insight**: Use **substitution** to determine answers. When substituting the outer `x`, substitution **stops** at the point where an inner `x` binding begins.

**DrRacket tip**: You can hover over variables and DrRacket draws blue arrows showing where each variable is bound. This confirms static scoping visually.

## Static scoping

- **Static scope** (or **lexical scope**): A variable's binding is determined by its **position in the source program**, not by the order of execution. You can determine bindings by examining program structure alone.
- **Dynamic scope**: A variable's binding depends on the **runtime execution order**. The same variable reference might resolve differently depending on execution path.

**Pitfall**: Dynamic scope is **unambiguously wrong** in language design.

- Original Lisp had it; Scheme fixed it over a decade later.
- Early Python and JavaScript had forms of dynamic scope. Removing it was a herculean effort.
- Those who don't know history are doomed to repeat it.

**Why dynamic scope is wrong** - consider this progression:

```scheme
{let1 {x 1}
  {+ {let1 {x 2} x}
     x}}
;; Should produce 3 (static) or 4 (dynamic)?
```

With dynamic scope, the inner binding might affect the outer `x`. Now consider:

```scheme
{let1 {x 1}
  {+ {cond {random}
           {let1 {x 2} x}
           4}
     x}}
;; With dynamic scope, binding structure changes based on random!

{let1 {x 1}
  {+ {cond {moon-is-currently-full}
           4
           {let1 {x 2} x}}
     x}}
;; Binding structure changes every two weeks!

```

**Consequence**: With dynamic scope, you cannot determine binding structure just by looking at the program. Neither can your tools:

- IDEs cannot draw arrows between bound and binding instances.
- Refactoring tools cannot safely rename variables.
- See Appendix 2 of research papers on Python semantics for examples of broken tooling.

**Static scope is a defining characteristic of SMoL.**

## Implementation: Substitution vs environment

**Substitution**: Textually replacing variables with values.

- Correctly defines semantics.
- **Inefficient**: Time linear in program size for each binding.
- Requires constantly rewriting program text.
- Not how real implementations work.

**Environment**: A **space-time tradeoff** that caches pending substitutions.

- A data structure mapping names to values (key-value pairs).
- When encountering a **binding**: extend the environment.
- When encountering a **variable**: look it up.

**Pitfall**: The environment is a **cache**. It should only improve performance, not change meaning. Substitution still defines **what answer** to produce; the environment is **how** we produce it efficiently.

## Environment implementation

```racket
(define-type-alias Env (hashof symbol Value))
(define mt-env (hash empty))  ;; "empty environment"

(define (lookup [s : symbol] [nv : Env]) : Value
  (type-case (optionof Value) (hash-ref nv s)
    [none () (error s "not bound")]
    [some (v) v]))

(define (extend [old-env : Env] [new-name : symbol] [value : Value]) : Env
  (hash-set old-env new-name value))
```

## Interpreter for local binding

The interpreter now takes an **environment parameter**:

```racket
(interp : (Exp Env -> Value))
```

Key cases:

```racket
[varE (s) (lookup s nv)]

[let1E (var val body)
       (let ([new-env (extend nv var (interp val nv))])
         (interp body new-env))]
```

**Pitfalls** - common implementation errors:

1. **Forgetting to evaluate**: Not calling `(interp val nv)` - the value expression must be evaluated before binding.
2. **Wrong environment for body**: Using `nv` instead of `new-env` when interpreting the body - the body needs the **extended** environment.
3. **Forgetting to thread environment**: Not passing `nv` through recursive calls for other cases like `plusE`.
4. **Worried about not removing bindings**: We extend but never shrink the environment. This is okay because we pass the **appropriate** environment to each recursive call. Inner `let1` creates a new extended environment; when that call returns, we're back to using the outer environment.

## Complete interpreter with local binding

```racket
#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [boolE (b : boolean)]
  [plusE (left : Exp) (right : Exp)]
  [varE (name : symbol)]
  [let1E (var : symbol) (value : Exp) (body : Exp)]
  [condE (test : Exp) (then : Exp) (else : Exp)])

(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)])

(define-type-alias Env (hashof symbol Value))

(define mt-env (hash empty))

(define (lookup [s : symbol] [nv : Env]) : Value
  (type-case (optionof Value) (hash-ref nv s)
    [none () (error s "not bound")]
    [some (v) v]))

(define (extend [old-env : Env] [new-name : symbol] [value : Value]) : Env
  (hash-set old-env new-name value))

(define (add [v1 : Value] [v2 : Value]) : Value
  (type-case Value v1
    [numV (n1)
          (type-case Value v2
            [numV (n2) (numV (+ n1 n2))]
            [else (error '+ "Expect RHS to be a number")])]
    [else (error '+ "Expect LHS to be a number")]))

(define (boolean-decision [v : Value]) : boolean
  (type-case Value v
    [boolV (b) b]
    [else (error 'if "Expect conditional to evaluate to a boolean")]))

(define (interp [e : Exp] [nv : Env]) : Value
  (type-case Exp e
    [numE (n) (numV n)]
    [boolE (b) (boolV b)]
    [varE (s) (lookup s nv)]
    [plusE (l r) (add (interp l nv) (interp r nv))]
    [let1E (var val body)
           (let ([new-env (extend nv var (interp val nv))])
             (interp body new-env))]
    [condE (c t e) (if (boolean-decision (interp c nv))
                       (interp t nv)
                       (interp e nv))]))

(define (parse [s : s-expression]) : Exp
  (cond
    [(s-exp-number? s) (numE (s-exp->number s))]
    [(s-exp-symbol? s) (varE (s-exp->symbol s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (if (= (length l) 0)
           (error 'parse "Unexpected empty s-expression")
           (let ([op (first l)])
             (if (not (s-exp-symbol? op))
                 (error 'parse "Unexpected operator")
                 (let ([op-sym (s-exp->symbol op)])
                   (cond
                     [(symbol=? '+ op-sym)
                      (plusE (parse (second l))
                             (parse (third l)))]
                     [(symbol=? 'cond op-sym)
                      (condE (parse (second l))
                             (parse (third l))
                             (parse (list-ref l 3)))]
                     [(symbol=? 'let1 op-sym)
                      (let ([binding (s-exp->list (second l))])
                        (let1E (s-exp->symbol (first binding))
                               (parse (second binding))
                               (parse (third l))))]
                     [else (error 'parse "Unexpected operator")]))))))]
    [else (error 'parse "Unexpected s-expression")]))

(define (run [s : s-expression]) : Value
  (interp (parse s) mt-env))

```

# Evaluating functions

## Core concepts

- Introduction rule: A construct that **creates** a new kind of value.
- Elimination rule: A construct that **uses/consumes** a value.
- Lambda expression: A function without an inherent name.
- Application/Function call: Applying a function to an argument.
- Closure: A function value that stores its **defining Environment**.
- Free variable: A variable used in an expression but not bound within it.
- Closed term: An expression with no unbound (free) variables.

- Procedure : An encapsulation that does **not** produce a value; must have side-effects to be useful.
- Function: An encapsulation that **always** produces a value (may be expected to have no side-effects).
- Pure: For a given input, always produces the same output, with no side-effects.
- Side-effect: A change to the system visible from outside the function body (e.g., modifying external variables, network I/O, file changes).

**Note**: The procedure/function distinction has been scrambled over the years; people now use the terms interchangeably.

## Functions in the language

Many languages have **top-level functions** only (like C). Most modern languages support:

- **Nested functions**: Functions defined inside other functions.
- **Returning functions**: Functions as return values.
- **Anonymous functions**: Functions without names.

**Key insight**: With anonymous functions (lambdas) and `let1`, we don't need named function syntax:

```scheme
;; Named function:
fun f(x):
  x + x

;; Equivalent with let1 and lambda:
let1 f = lam(x): x + x
```

## Syntax for functions

BNF grammar extension:

```
<expr> ::= ...
         | {lam <var> <expr>}
         | {<expr> <expr>}
```

- **`lam`** introduces new functions (takes parameter name and body).
- **Application** `{<expr> <expr>}` eliminates functions (takes function expression and argument expression).
- We assume **single-argument functions** for simplicity.

**Exercise awareness**: Extending to multiple arguments raises issues - how to handle different numbers of arguments, parameter/argument count mismatch, etc.

Examples:

```scheme
{let1 {f {lam x {+ x x}}}
  {f 3}}
;; => 6

{let1 {x 3}
  {let1 {f {lam y {+ x y}}}
    {f 3}}}
;; => 6
```

Parsed ASTs:

```racket
(let1E 'f (lamE 'x (plusE (varE 'x) (varE 'x)))
  (appE (varE 'f) (numE 3)))

(let1E 'x (numE 3)
  (let1E 'f (lamE 'y (plusE (varE 'x) (varE 'y)))
    (appE (varE 'f) (numE 3))))
```

## Functions as values

**Problem**: What does `{lam x {+ x x}}` evaluate to?

```racket
> (lambda (x) (+ x x))
#<procedure>

> (number? (lambda (x) (+ x x)))
#f
```

Functions are values **distinct from numbers or booleans**. The interpreter must return function values, not just numbers.

**First attempt** - `funV` with no information:

```racket
(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)]
  [funV])  ;; No information!
```

**Problem**: Consider:

```scheme
{{cond {zero? x}
       {lam x {+ x 1}}
       {lam x {- x 2}}}
 5}
```

Both branches produce `funV` with no distinguishing information. We cannot perform the application!

**Solution**: `funV` must store **parameter name** and **body expression**:

```racket
(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)]
  [funV (var : symbol) (body : Exp)])
```

## Evaluating functions (naive approach)

**`lamE` case** - straightforward:

```racket
[lamE (v b) (funV v b)]

```

**`appE` case** - the process:

1. Evaluate the **function position** to get a value.
2. Evaluate the **argument position** (eager evaluation, SMoL style).
3. Check that function position produced a **function value**. If not, error.
4. **Extend the environment** with formal parameter bound to actual argument value.
5. Evaluate the **body** in this extended environment.

```racket
[appE (f a)
      (let ([fv (interp f nv)]
            [av (interp a nv)])
        (type-case Value fv
          [funV (v b)
                (interp b (extend nv v av))]
          [else (error 'app "Expected a function")]))]
```

## The interpreter so far

At this point, we have a **full programming language** in roughly **20 lines of code**.

**Alan Kay quote** (Turing Award winner):

> "Yes, that was the big revelation to me when I was in graduate school-when I finally understood that the half page of code on the bottom of page 13 of the Lisp 1.5 manual was Lisp in itself. These were 'Maxwell's Equations of Software!' This is the whole world of programming in a few lines that I can put my hand over."
> 

The power of an interpreter: it lets you **exploit features already built** in the host language instead of reimplementing everything from scratch.

## The closure problem

**Pitfall**: The naive implementation above leads to **dynamic scope**!

**Test case 1**:

```scheme
{let1 {x 1}
  {let1 {f {lam y x}}
    {let1 {x 2}
      {f 10}}}}
```

- **Expected** (static scope): Returns **1**. The `x` in `f` refers to the `x` when `f` was defined.
- **Broken** (dynamic scope): Returns **2**. The `x` in `f` picks up the most recent binding.

**Test case 2** (even worse):

```scheme
{let1 {f {lam y x}}
  {let1 {x 1}
    {f 10}}}
```

- **Expected**: **Unbound identifier error** (`x` not defined when `f` is created).
- **Broken interpreter**: Returns **1** (finds `x` from later binding).

**This is dynamic scope** - the binding depends on the runtime call stack, not the source position.

## Understanding the fix via substitution

Substitution shows us the correct behavior:

```scheme
(let ([x 1])
  (let ([f (lambda (y) x)])
    (let ([x 2])
      (f 10))))
```

**Step 1**: Substitute 1 for `x`:

```scheme
(let ([f (lambda (y) 1)])  ;; x replaced with 1 inside lambda!
  (let ([x 2])
    (f 10)))
```

**Step 2**: Substitute `f`:

```scheme
(let ([x 2])
  ((lambda (y) 1) 10))
```

**Step 3**: Substitute 2 for `x` (no `x`'s left!):

```scheme
((lambda (y) 1) 10)
```

**Key insight**: The substitution of `x` with `1` **already happened** inside the lambda body. The later binding of `x` to `2` is a **different** `x`.

The environment **represents substitutions waiting to happen**. We must remember them at the right time.

## The solution: closures

A **closure** stores the environment at function creation time.

```racket
(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)]
  [funV (var : symbol) (body : Exp) (nv : Env)])
```

**Terminology**:

- Closed term: An expression with no unbound variables.
- The Closure "closes" over the defining environment, ensuring free variables in the body can get values from the stored environment.

**Cormac Flanagan quote**: "Save the environment! Create a closure today!"

**James Iry quote**: "Lambdas are relegated to relative obscurity until Java makes them popular by not having them."

**At function creation**: Capture current environment in the closure:

```racket
[lamE (v b) (funV v b nv)]  ;; Store nv!
```

**At application**: Use the **stored environment**, not the calling environment:

```racket
[appE (f a)
      (let ([fv (interp f nv)]
            [av (interp a nv)])
        (type-case Value fv
          [funV (v b closure-env)
                (interp b (extend closure-env v av))]  ;; Use closure-env!
          [else (error 'app "Expected a function")]))]
```

**Pitfall**: The `closure-env` in the `funV` case **intentionally shadows** the outer `nv`. The body must be evaluated in the **closure's environment** extended with the argument, **not** the calling environment.

## Escaping closures

**Subtle test**: Closures must work even when used **outside their defining scope**:

```scheme
{{let1 {x 3}
   {lam y {+ x y}}}
 4}
```

- The lambda captures `x = 3` in its closure.
- The let1 evaluates to the closure (the closure **escapes** the let1 scope).
- This closure is then applied to 4.
- Result: **7** (uses stored `x = 3`).

**Another test** - parameter shadowing:

```scheme
{{let1 {y 3}
   {lam y {+ y 1}}}
 5}
```

- The lambda captures environment where `y = 3`.
- But the lambda's **own parameter** is also `y`.
- When applied to 5, the parameter `y` shadows the captured `y`.
- Result: **6** (not 4).

## Relationship between `let1` and `lam`

**Key insight**: `let1` can be **desugared** to lambda + application:

```scheme
{let1 {x v} body}
;; is equivalent to:
{{lam x body} v}
```

This means `let1` is not strictly necessary as a primitive - it's **syntactic sugar**. However, keeping it makes programs more readable.

## Complete interpreter with functions

```racket
#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [boolE (b : boolean)]
  [plusE (left : Exp) (right : Exp)]
  [varE (name : symbol)]
  [let1E (var : symbol) (value : Exp) (body : Exp)]
  [condE (test : Exp) (then : Exp) (else : Exp)]
  [lamE (var : symbol) (body : Exp)]
  [appE (fun : Exp) (arg : Exp)])

(define-type Value
  [numV (the-number : number)]
  [boolV (the-boolean : boolean)]
  [funV (var : symbol) (body : Exp) (nv : Env)])

(define-type-alias Env (hashof symbol Value))

(define mt-env (hash empty))

(define (lookup [s : symbol] [nv : Env]) : Value
  (type-case (optionof Value) (hash-ref nv s)
    [none () (error s "not bound")]
    [some (v) v]))

(define (extend [old-env : Env] [new-name : symbol] [value : Value]) : Env
  (hash-set old-env new-name value))

(define (add [v1 : Value] [v2 : Value]) : Value
  (type-case Value v1
    [numV (n1)
          (type-case Value v2
            [numV (n2) (numV (+ n1 n2))]
            [else (error '+ "Expect RHS to be a number")])]
    [else (error '+ "Expect LHS to be a number")]))

(define (boolean-decision [v : Value]) : boolean
  (type-case Value v
    [boolV (b) b]
    [else (error 'if "Expect conditional to evaluate to a boolean")]))

(define (interp [e : Exp] [nv : Env]) : Value
  (type-case Exp e
    [numE (n) (numV n)]
    [boolE (b) (boolV b)]
    [varE (s) (lookup s nv)]
    [plusE (l r) (add (interp l nv) (interp r nv))]
    [let1E (var val body)
           (let ([new-env (extend nv var (interp val nv))])
             (interp body new-env))]
    [condE (c t e) (if (boolean-decision (interp c nv))
                       (interp t nv)
                       (interp e nv))]
    [lamE (v b) (funV v b nv)]
    [appE (f a)
          (let ([fv (interp f nv)]
                [av (interp a nv)])
            (type-case Value fv
              [funV (v b closure-env)
                    (interp b (extend closure-env v av))]
              [else (error 'app "Expected a function")]))]))

(define (parse [s : s-expression]) : Exp
  (cond
    [(s-exp-number? s) (numE (s-exp->number s))]
    [(s-exp-symbol? s) (varE (s-exp->symbol s))]
    [(s-exp-list? s)
     (let ([l (s-exp->list s)])
       (cond
         [(= (length l) 0)
          (error 'parse "Unexpected empty s-expression")]
         [(= (length l) 2)
          ;; Application: {<expr> <expr>}
          (appE (parse (first l))
                (parse (second l)))]
         [(s-exp-symbol? (first l))
          (let ([op-sym (s-exp->symbol (first l))])
            (cond
              [(symbol=? '+ op-sym)
               (plusE (parse (second l))
                      (parse (third l)))]
              [(symbol=? 'cond op-sym)
               (condE (parse (second l))
                      (parse (third l))
                      (parse (list-ref l 3)))]
              [(symbol=? 'let1 op-sym)
               (let ([binding (s-exp->list (second l))])
                 (let1E (s-exp->symbol (first binding))
                        (parse (second binding))
                        (parse (third l))))]
              [(symbol=? 'lam op-sym)
               (lamE (s-exp->symbol (second l))
                     (parse (third l)))]
              [else
               ;; Could be application with symbol in function position
               (appE (parse (first l))
                     (parse (second l)))]))]
         [else
          ;; Application with non-symbol in function position
          (if (= (length l) 2)
              (appE (parse (first l))
                    (parse (second l)))
              (error 'parse "Unexpected s-expression"))]))]
    [else (error 'parse "Unexpected s-expression")]))

(define (run [s : s-expression]) : Value
  (interp (parse s) mt-env))

```

# Summary table

| Concept | Definition | Pitfall/Awareness |
| --- | --- | --- |
| **Binding** | Associating a name with a value | Must have both binding syntax and usage syntax |
| **Scope** | Region where a binding is visible | Parenthetical syntax makes boundaries explicit |
| **Local binding** | Binding limited to a region | Not available outside that region |
| **Shadowing** | Inner binding hides outer binding of same name | Outer binding is **not modified**, just temporarily hidden |
| **Static scope** | Binding determined by source position | SMoL uses this; enables IDE tooling; determined without running the program |
| **Dynamic scope** | Binding determined by runtime execution | **Unambiguously wrong**; makes programs unpredictable; broke early Lisp, Python, JavaScript |
| **Substitution** | Textually replacing variables with values | Correct semantics but inefficient (linear time per binding) |
| **Environment** | Data structure caching pending substitutions | Should not change meaning, only improve performance |
| **Introduction** | Construct that creates a new kind of value | For functions: `lam` |
| **Elimination** | Construct that uses/consumes a value | For functions: application |
| **Lambda** | Anonymous function | Named functions are just let1 + lambda |
| **Application** | Calling a function with argument | Five steps: eval fun, eval arg, check fun, extend env, eval body |
| **Closure** | Function value storing its defining environment | **Must** use stored env at application, not calling env |
| **Free variable** | Variable used but not bound in expression | Closures ensure free variables get values from stored env |
| **Closed term** | Expression with no unbound variables | Closures "close" over the environment |
| **Eager evaluation** | Evaluate arguments before function body | SMoL uses this; argument evaluated in calling env |
| **funV without env** | `[funV (var : symbol) (body : Exp)]` | Leads to dynamic scope - **wrong**! |
| **funV with env** | `[funV (var : symbol) (body : Exp) (nv : Env)]` | Correct implementation for static scope |
| **let1 desugaring** | `{let1 {x v} body}` ≡ `{{lam x body} v}` | let1 is syntactic sugar over lambda + application |
| **Escaping closure** | Closure used outside its defining scope | Must still work correctly; tests static scope |
| **Parameter shadowing** | Lambda parameter shadows captured variable of same name | `{{let1 {y 3} {lam y {+ y 1}}} 5}` => 6, not 4 |
| **Evaluating f and a** | Use current env `nv`, not closure env | Closure doesn't exist yet for f; a is in calling scope |
| **Environment threading** | Pass environment through all recursive interp calls | Forgetting causes wrong scoping |
| **Maxwell's Equations of Software** | ~20 lines for complete language interpreter | Alan Kay's term for the profound simplicity |

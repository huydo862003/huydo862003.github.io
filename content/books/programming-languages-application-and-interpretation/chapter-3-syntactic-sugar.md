---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 3. syntactic sugar
author: Shriram Krishnamurthi
date: ""
journey: plt
tags: []
concepts:
  - macro
  - macro-system
  - syntactic-sugar
  - desugarer
  - macro-expansion
  - macro-parenthetical-language
  - macro-hygienic-macro
  - macro-side-effect
parent: programming-languages-application-and-interpretation
children: []
---

# Syntactic sugar

## Core concepts

- Core calculus/language: The minimal set of constructs that the implementation handles directly.
- Surface language: The language programmers actually write in, which may have many conveniences.
- Syntactic sugar: Extra constructs in the surface language that make programming "sweeter" (more convenient). These are not handled directly but translated to core constructs.
- Desugaring: The process of removing sugar - translating Surface language programs down to the Core calculus/language.
- Desugarer: The program that performs desugaring. Technically a **compiler** from surface to core, but since core is a subset of surface, it's a special case.
- Macro: A Syntactic abstraction that rewrites program source into other program source before evaluation.
- Macro expansion: The process of applying macro transformations to produce core language code.
- Macro system: A facility that provides program rewriting capabilities directly to the programmer.

- Most languages have Syntactic sugar (built into the compiler).
- Very few languages have Macro systems (expose rewriting to programmers).

## Why syntactic sugar matters

**The redundancy problem**: Many language constructs overlap in functionality.

Example - `for` and `while` in C:

```c
for(x = 0; x < 10; x++) {
    sum += x;
}

// is exactly the same as:

x = 0;
while (x < 10) {
    sum += x;
    x++;
}
```

**General pattern**:

```c
for(INITIAL; CONDITIONAL; UPDATE) {
    BODY;
}

// desugars to:

INITIAL;
while (CONDITIONAL) {
    BODY;
    UPDATE;
}
```

**The implementor's dilemma**:

- `while` implementation requires recursive calls, iteration, checking, bookkeeping, scope management.
- Without desugaring, all that work must be **duplicated** for `for`.
- Bug fixes must be applied to **both** implementations.

**The solution**: Implement `while` once, translate `for` into `while`.

**Why have both constructs?**

- Each is convenient for different purposes.
- `for` signals a certain stylistic pattern that would be harder to spot in raw `while` code.
- It adds to **programmer vocabulary** without adding to **implementor pain**.

## Real-world desugaring examples

- **`and`/`or`**: Desugar into nested `if`s.
- **JavaScript `o.x`**: Desugars into `o["x"]`.
- **`x += y`**: Sugar for `x = x + y`.
- **Python `+`**: Desugars into method call `__add__`.
- **Python dunder methods**: `__add__`, `__str__`, etc. A whole "protocols" programming style evolved around these.
- **List comprehensions** (Haskell, Python): Desugar into function/method calls.

**Awareness**: If you don't notice desugaring, that's part of the point - you feel like working with a larger syntax than the implementor manages.

## Implementation approaches to desurgaring

**Approach 1 - AST rewriting**:

- Parse program normally into full AST.
- Rewrite AST into a subset of itself (core AST).

**Approach 2 - Macro system**s (Parenthetical language):

- Two levels of parsing: coarse parenthetical level, then finer AST level.
- Rewrite at the parenthetical level **before** AST parsing.
- Internal AST only needs to cover core language.

**Pitfall** in real implementations: If you make an error using `for` but the error is reported in terms of `while`, you'd be confused. Modern desugaring systems (like Racket's) have special support to handle error reporting correctly.

# Macros by example

## Setup

Switch to `#lang racket` for macro examples. The restrictions and types of `plait`/`plai-typed` can interfere with macro writing.

```racket
#lang racket
```

## Example 1: a strict conditional

**Goal**: Racket's `if` is truthy/falsy. We want a **`strict-if`** that accepts only Booleans.

**First attempt** - as a function:

```racket
(define (strict-if C T E)
  (if (boolean? C)
      (if C T E)
      (error 'strict-if "expected a boolean")))
```

Testing:

```racket
(strict-if true 1 2)   ;; => 1
(strict-if 0 1 2)      ;; => error (good!)

```

**Pitfall**: This fails because of **eager evaluation**:

```racket
(strict-if true 1 (/ 1 0))  ;; => error! Division by zero
(if true 1 (/ 1 0))         ;; => 1 (correct)
```

The whole point of a conditional is to **avoid evaluating** one branch. Functions evaluate all arguments first - we need **macros**.

**Correct solution** - as a macro:

```racket
(define-syntax strict-if
  (syntax-rules ()
    [(strict-if C T E)
     (if (boolean? C)
         (if C T E)
         (error 'strict-if "expected a boolean"))]))
```

**Macro components**:

- **`define-syntax`**: Declares a new piece of syntax (not a function).
- **`syntax-rules`**: Introduces a pattern-matcher. The `()` is required (for now, ignore its meaning).
- **Pattern**: `(strict-if C T E)` - matches input and binds `C`, `T`, `E` to corresponding source code.
- **Output template**: The expression that replaces the macro use, with pattern variables substituted.

**Expansion example**:

```racket
(strict-if true 1 (/ 1 0))

;; expands to:

(if (boolean? true)
    (if true 1 (/ 1 0))
    (error 'strict-if "expected a boolean"))
```

Now `(/ 1 0)` is only evaluated if the `if` chooses that branch.

**DrRacket tip**: Use the **Macro Stepper** to see step-by-step expansion. Set "Macro hiding" to "Standard" at bottom-left.

**Awareness**: The Macro Stepper is **not an evaluator**. It shows expansion steps, not evaluation steps. Runtime errors won't appear - only syntax errors.

## Example 2: local binding

**Goal**: Define `my-let1` that binds one variable:

```racket
(my-let1 (x 3) (+ x x))  ;; => 6
```

**Why can't `let1` be a function?**

- Would try to evaluate `(x 3)` as an argument.
- `(x 3)` looks like an application, but `x` isn't bound.
- No meaningful "value" - its job is to **bind** `x`.

**Terminology**: New pieces of syntax are called **constructs** or **special forms** (forms with special binding/evaluation rules).

**Solution** - using Left-left-lambda:

```racket
(define-syntax my-let1
  (syntax-rules ()
    [(my-let1 (var val) body)
     ((lambda (var) body) val)]))
```

**Key insight**: What does `let1` do?

- Binds a name to a value.
- Evaluates body in extended environment.

What else does this? **Functions**! A function:

- Binds formal parameter to argument value.
- Evaluates body in extended environment.
- Evaluates body **when applied**.

So `let1` is an [Immediately invoked function expression (IIFE)](/journeys/plt/concepts/immediately-invoked-function-expression-iife).

**Terminology**: This pattern is called Left-left-lambda (for the left parentheses). JavaScript popularized it as [Immediately invoked function expression (IIFE)](/journeys/plt/concepts/immediately-invoked-function-expression-iife) due to scope problems in early versions.

**Exercise pitfall** - swapping parts:

```racket
(define-syntax my-let1
  (syntax-rules ()
    [(my-let1 (var val) body)
     ((lambda (var) val) body)]))  ;; WRONG! val and body swapped

(my-let1 (x 3) (+ x x))
;; expands to: ((lambda (x) 3) (+ x x))
;; x is unbound in (+ x x)!
```

## Example 3: binding multiple locals

**Goal**: Bind many names at once, like Racket's `let`:

```racket
(my-let2 ([x 3] [y 4]) (+ x y))  ;; => 7
```

**Pattern**: The function takes multiple formals, applied to multiple actuals.

**Syntax**: Use **ellipsis** (`...`) for sequences of arbitrary length:

```racket
(define-syntax my-let2
  (syntax-rules ()
    [(my-let2 ([var val] ...) body)
     ((lambda (var ...) body) val ...)]))
```

**Reading the pattern**:

- `([var val] ...)` matches **zero or more** var-val pairs.
- `(var ...)` in output produces all the `var`s.
- `(val ...)` in output produces all the `val`s.

## Example 4: multi-armed conditional

**Goal**: Define `my-cond` with multiple question-answer arms:

```racket
(define (sign n)
  (my-cond
    [(< n 0) "negative"]
    [(= n 0) "zero"]
    [(> n 0) "positive"]))
```

**Design**:

- Peel off first question-answer pair.
- If question is true, evaluate answer.
- Otherwise, recur on remaining pairs (smaller instance of `my-cond`).
- If all questions exhausted, produce error.

**Solution** - recursive macro:

```racket
(define-syntax my-cond
  (syntax-rules ()
    [(my-cond)
     (error 'my-cond "should not get here")]
    [(my-cond [q0 a0] [q1 a1] ...)
     (if q0
         a0
         (my-cond [q1 a1] ...))]))

```

**Key insight**: `[q0 a0]` peels off the first pair. `[q1 a1] ...` captures all remaining pairs. The macro **recurs on syntax**.

# More on macros

## Definitional convenience

**The underscore pattern**: Don't repeat the macro name in the pattern - use `_` instead:

```racket
(define-syntax unless
  (syntax-rules ()
    [(_ cond body ...)
     (if (not cond)
         (begin body ...)
         (void))]))
```

Usage:

```racket
(unless false
  (println 1)
  (println 2))
```

**Awareness**: `_` and repeating the macro name do slightly different things in subtle situations. You should always use `_`.

## Hygiene

**The capture problem** - consider:

```racket
(let ([not (λ (v) v)])  ;; redefine `not` to be identity!
  (unless false
      (println 1)
      (println 2)))
```

This seems to expand to:

```racket
(let ([not (λ (v) v)])
  (if (not false)  ;; uses the wrong not?
      (begin
        (println 1)
        (println 2))
      (void)))
```

If the outer `not` **captured** the inner `not`, the conditional would be inverted!

**The solution - Hygienic macro**:

- Variables are more than just names.
- Variables record **binding information** that keeps names introduced in different settings separate.

Conceptually, it's like using colors:

```racket
;; Original (red = user's not, blue = macro's not):
(let ([not (λ (v) v)])    ;; red not
  (unless false ...))

;; After expansion:
(let ([not (λ (v) v)])    ;; red not
  (if (not false)         ;; blue not (different!)
      ...))
```

The macro expander can use distinct fresh names internally: `not1`, `not2`, etc.

**Hygiene** is an analog of **static scoping for macros**:

- Macro writers can use any name without worrying about use context.
- Macro users can use any name without worrying about macro internals.

**Pitfall**: The C preprocessor does **not** have hygiene. Name capture is a real danger there.

## Truthy/falsy idiom: `or`

**First attempt**:

```racket
(define-syntax or-2
  (syntax-rules ()
    [(_ e1 e2)
     (if e1 true e2)]))
```

Works for basic cases:

```racket
(or-2 true false)   ;; => true
(or-2 false false)  ;; => false
(or-2 false true)   ;; => true
```

**Problem**: Loses useful return values:

```racket
(member 'y '(x y z))  ;; => '(y z), a truthy value

(or-2 (member 'y '(x y z)) "not found")  ;; => true (lost the list!)
```

**Second attempt** - return the value:

```racket
(define-syntax or-2
  (syntax-rules ()
    [(_ e1 e2)
     (if e1 e1 e2)]))

```

Now `(or-2 (member 'y '(x y z)) "not found")` returns `'(y z)`.

## Macro definition hazard: duplication

**Pitfall**: The second `or-2` has a subtle hazard:

```racket
(or-2 (print "hello") "not found")
;; prints "hello" TWICE!
```

**Why?** Macros are **syntactic** abstractions. `(if e1 e1 e2)` **copies** `e1` twice into the output. This:

- Causes computation to happen twice.
- Blows up program size.
- Is especially problematic for **side effects**.

**Solution** - bind to a local variable:

```racket
(define-syntax or-2
  (syntax-rules ()
    [(_ e1 e2)
     (let ([v e1])
       (if v v e2))]))
```

**Awareness**: The `let` works because `e1` is **guaranteed to be evaluated** anyway (it's the condition). If we put `let` where something might not be evaluated, we'd force evaluation incorrectly.

## Hygiene for local variables

**Question**: Does hygiene protect local variables too?

```racket
(let ([v 1])
  (or-2 false v))
```

The macro introduces its own `v`. Does it capture the user's `v`?

**With hygiene** (what Racket does):

```racket
(let ([v0 1])
  (let ([v1 false])
    (if v1 v1 v0)))
;; => 1 (correct!)
```

**Without hygiene** (what would be wrong):

```racket
(let ([v 1])
  (let ([v false])
    (if v v v)))
;; => false (wrong!)
```

**Key insight**: Hygiene works for **all** names - built-in functions, local variables, everything. You can use names freely in macros just as in functions.

## Generalizing to n-ary

**Goal**: Define `orN` that takes any number of arguments.

**First attempt**:

```racket
(define-syntax orN
  (syntax-rules ()
    [(_ e1 e2 ...)
     (let ([v e1])
       (if v v (orN e2 ...)))]))

```

**Problem**:

```racket
(let ([v true])
  (orN false v))
;; Error: orN: bad syntax in: (orN)

```

The pattern `(_ e1 e2 ...)` requires **one or more** arguments. When recursion reaches zero arguments, no pattern matches.

**Solution** - add base case:

```racket
(define-syntax orN
  (syntax-rules ()
    [(_) false]
    [(_ e1 e2 ...)
     (let ([v e1])
       (if v v (orN e2 ...)))]))

```

**Exercise awareness**: Why not just use `(_ e ...)` for zero-or-more? Try it - you'll find it doesn't work straightforwardly because you need to handle the sequence differently.

# Summary table

| Concept | Definition | Pitfall/Awareness |
| --- | --- | --- |
| **Core language** | Minimal constructs handled directly by implementation | Keep it small to minimize implementation/maintenance burden |
| **Surface language** | What programmers write; includes conveniences | Can be much larger than core |
| **Syntactic sugar** | Surface constructs that translate to core | If you don't notice it, that's the point |
| **Desugaring** | Translating surface to core language | Must handle error reporting carefully |
| **Desugarer** | Program that removes sugar | Technically a compiler (surface → core) |
| **Macro** | Syntactic abstraction; rewrites source to source | Not a function - operates on syntax, not values |
| **Macro expansion** | Applying macro transformations | Happens before evaluation |
| **Macro system** | Exposes rewriting to programmers | Rare - most languages have sugar but not macros |
| **`define-syntax`** | Declares new syntax in Racket | Use instead of `define` for macros |
| **`syntax-rules`** | Pattern-based macro definition | Empty `()` required |
| **Pattern variables** | Names in pattern that bind to source code | Get substituted into output template |
| **Ellipsis (`...`)** | Matches zero or more of preceding pattern | Need base case for recursive macros |
| **Underscore (`_`)** | Placeholder for macro name in pattern | Preferred over repeating macro name |
| **Left-left-lambda** | Immediately applied anonymous function | JavaScript calls it IIFE |
| **Hygiene** | Prevents name capture in macros | Analog of static scope for macros |
| **Name capture** | Outer binding interferes with macro internals | Hygiene prevents this automatically |
| **Fresh names** | Internally distinct names for same-named variables | How hygiene is implemented |
| **C preprocessor** | Macro system without hygiene | Name capture is real danger |
| **Duplication hazard** | Pattern variable copied multiple times | Causes repeated evaluation; use `let` to bind once |
| **Side effects in macros** | Observable effects duplicated if pattern var copied | Especially dangerous - always bind to variable |
| **Truthy return idiom** | Return truthy value, not just `true` | `(if e1 e1 e2)` but beware duplication |
| **Macro Stepper** | DrRacket tool for viewing expansion | Not an evaluator - shows syntax transformation only |
| **Base case** | Pattern for zero arguments in recursive macro | `(_ e1 e2 ...)` requires 1+, need `(_)` for 0 |
| **`let1` desugaring** | `(let1 (x v) body)` → `((lambda (x) body) v)` | Demonstrates let as sugar over lambda |
| **`for` desugaring** | `for` → `while` with init/update | Classic example of reducing implementation burden |

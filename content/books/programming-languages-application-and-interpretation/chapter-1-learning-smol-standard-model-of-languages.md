---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Chapter 1. learning SMoL - standard model of languages"
author: Shriram Krishnamurthi
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - local-binding-form
  - parallel-simultaneous-let
  - recursive-let
  - cascading-sequential-let
  - lexical-static-scope
  - first-order-variable
  - closure
  - aliasing
  - block
  - primordial-block
  - binding
  - environment
  - garbage-collection
  - automatic-memory-management
parent: programming-languages-application-and-interpretation
children: []
---

Link: https://smol-tutor.xyz/tutor/.

# [`def1`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **SMoL - Standard Model of Languages**
    - Captures the **shared computational core** across widely-used languages (C#, Java, JavaScript, Python, Scala, Racket, and more).
    - **8 core features:**
        - Lexical scope.
        - Nested scope.
        - Eager evaluation.
        - Sequential evaluation (per thread).
        - Mutable first-order variables.
        - Mutable first-class structures (objects, vectors, etc.).
        - Higher-order functions with closures.
        - Automated memory management (garbage collection).
    - **Inclusion criteria:** Feature must be present across many diverse languages.
        - Excluded: static types (not universal), objects (too much variation).
    - **Descriptive, not prescriptive** - models what languages *are*, not what they *should be.*
- **Variable definition** → creates a *binding* between a name and a value.
    
    
    ```lisp
    (defvar x 1) 
    ```
    
    ```python
    x = 1
    ```
    
    - **Binding**: `x` bound to `1`.
    - **Lisp syntax**: `(operator arg1 arg2 ...)` - prefix notation, everything parenthesized.
- **Function definition**
    
    
    ```lisp
     (deffun (f x y) body) 
    ```
    
    ```jsx
    function f(x, y) { return body; }
    ```
    
    - **Formal parameters** → variables in the definition.
    - **Actual parameters** (arguments) → values passed at call time.
- **Nested definitions**: function bodies can contain variable definitions.
    - `(defvar n (+ x y))` inside function → `n` is a **local variable**.
- **Block** → a sequence of definitions and expressions.
    - Two places definitions can appear: **top-level block** and **function bodies**.
    - Blocks form a **tree-like (nested) structure**.
- **Values** → typical computation results: numbers, strings, booleans, etc.
- **Error** → another possible outcome of running a program.
    - Errors **halt execution** immediately - subsequent expressions don't run.
- **Sequential evaluation**: expressions run in order until completion or error.

# [`def2`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Variable lookup** follows the hierarchical block structure (lexical scope).
    
    **Lookup order:**
    
    1. Check current block.
    2. If not found → check enclosing block (where current block is defined).
    3. Repeat recursively outward.
    4. Top-level block's parent → **primordial block**.
    5. If still not found → **error**.
- **Primordial block** → invisible block enclosing top-level; contains language built-ins (e.g., `+`, `/`, `print`).
- This is **lexical/static scoping**: variable resolution based on code structure, not runtime call stack.
- **Scope** → the region of a program where a variable can be referenced.
    - Scope includes: the block where it's defined + all sub-blocks.
    - **Shadowing** → when an inner block defines a variable with the same name as an outer block, the inner definition "shadows" (hides) the outer one.

# [`def3`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Variables are bound to values** (not expressions).
- **Eager evaluation**: expressions are evaluated *immediately* at definition time.
    - `(defvar x (+ 1 2))` → `x` is bound to `3`, not to `(+ 1 2)`.
    - Happens even if the variable is never used later.
- **Function calls**: arguments evaluated immediately before binding to formal parameters.
    - Even if a parameter is never used in the function body.
- **Sequential evaluation**: blocks execute in reading order (top-to-bottom, left-to-right).

# [`post1`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- Nested functions can access variables from all enclosing scopes (lexical scope chain).
- Local variables are **not visible outside** their defining block.
- Referencing an undefined variable → **error**.
- Definitions processed **top-to-bottom** - can't use a variable before it's defined.
- Eager evaluation: RHS expression must be computable at definition time.

# [`vectors1`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Mutable values** → values that can be changed after creation (e.g., vectors).
- **Vector** → an ordered collection that holds references to other values.
    
    
    ```lisp
    (mvec ...)
    ```
    
    ```python
    [...]
    ```
    
    Vectors can contain: numbers, other vectors, or be empty.
    
    Examples:
    
    - `(mvec 1 2)` → `vec[1, 2]` (two elements).
    - `(mvec 3)` → `vec[3]` (one element).
    - `(mvec)` → `vec[]` (empty).
    - `(mvec (mvec 1 2) (mvec 3) (mvec))` → `vec[vec[1,2], vec[3], vec[]]` (nested - holds references to the other three).
    - Vectors hold **references** to values, not copies.
    
    ```lisp
    (vec-ref vec idx)
    ```
    
    ```python
    vec[idx]
    ```
    
    - **0-indexed**: first element is at position `0`.
- **Mutation** → changing the contents of a value after it's created.
    
    
    ```lisp
    (vec-set! vec idx val)
    ```
    
    ```python
    vec[idx] = val
    ```
    
    - `!` convention in Lisp: functions ending with `!` typically mutate something.
    - The vector itself isn't replaced; its **contents** are modified in place.

# [`vectors2`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Aliasing** → multiple references pointing to the same vector (no copying).
- Vectors are **never implicitly copied**:
    - Assigning to a new variable → same vector.
    - Passing to a function → same vector.
    - Nesting in another vector → same vector.
- **Heap** → memory region where vectors live; maps addresses to vectors.
- **Heap address** → unique identifier for each vector (e.g., `@100`, `@200`)
    - Notation only - actual numbers are arbitrary/random.
- **Bindings vs. Heap are independent**:
    - Creating a vector doesn't require a variable binding.
    - Creating a binding doesn't modify the heap.
- Implication: mutating a vector through one reference affects all aliases.

# [`vectors3`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Heap notation & Rules**
    - `@ddd` (e.g., `@100`, `@200`) → heap addresses (arbitrary numbers)
    - `#(...)` → vector contents at that address
    - Heap maps addresses **only to vectors** (not primitives like `33`)
    - Vectors store **values** (numbers or addresses), not printed representations like `#(3 4)`.

# [`post2`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- Assigning a vector to another variable creates an **alias**, not a copy - mutations via one affect the other.
- Can't reference a variable before its definition (eager, sequential evaluation).
- Passing a vector to a function passes the **reference** - mutations inside the function affect the original.
- Nested functions access enclosing scopes (lexical scope chain).
- Local variables inside functions are **not visible** at top-level → error.
- Vectors can reference **themselves** (self-referential structures are valid).
- Nested vectors store references - mutating an inner vector is visible through the outer vector's reference.

# [`mutvars1`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Variable assignment** (`set!`) mutates a variable's binding to a new value.
- **Variables are not aliased** - assignment affects only the mutated variable, not others.
- Assigning `y = x` copies the *value*, not a reference to the variable - later changes to `x` don't affect `y`.
- Vectors capture values at creation time - later variable reassignment doesn't affect stored values.
- Reassigning a variable holding a vector creates a new binding, doesn't affect other references to the old vector.
- Function parameters are independent bindings - mutating one doesn't affect the other.
- **Key distinction**: `set!` changes *which value* a variable points to; `vec-set!` changes *contents* of the value itself.

# [`mutvars2`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Variable assignment (`set!`) mutates existing bindings** - does not create new bindings; assigning to an undefined variable errors.
- **Functions see the latest values** of outer variables at call time, not the values from when the function was defined.
- **Environments** (not blocks) bind variables to values - created dynamically at runtime like vectors on the heap.
- **Every function call creates a new environment** - same function called twice = two separate environments with independent bindings.
- **What creates bindings**: definitions and function calls (for parameters).
- **What mutates bindings**: only variable mutations (`set!`).

# [`post3`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Vectors are aliased** - multiple variables pointing to the same vector share it; mutations via one affect all.
- **Variable assignment (`set!`) only rebinds that variable** - doesn't affect other variables or vectors that already captured the old value.
- **Vectors passed to functions share the same reference** - mutating vector contents inside a function affects the original.
- **Function parameters are separate bindings** - mutating a parameter doesn't affect the caller's variable.
- **Functions always see the current value** of outer variables at call time, not values from when the function was defined.

# [`refactor`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Each `(mvec ...)` call creates a new, distinct vector** - reusing a variable instead of calling `mvec` again introduces aliasing.
- **Aliasing can break code** - if code expects two independent vectors, making them share the same reference causes mutations to affect both.
- **Passing the same variable vs. a fresh vector to a function** - can break if the function mutates the argument (original vector gets modified).
- **Order of definitions matters** - can't reference a variable before it's defined.
- **Safe refactorings**: copying element-by-element into a new vector preserves independence; reusing variables for immutable/primitive values is safe.

# [`lambda1`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Functions are first-class values** - they can be treated like any other value (numbers, vectors, etc.).
- Functions can be: bound to variables, passed as arguments, returned from other functions, and stored in vectors.
- A function stored in a variable can be called via that variable - multiple variables can reference the same function.

# [`lambda2`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Closures** - functions remember the environment in which they were defined, "closing over" the bindings available at creation time
- **Each function call creates a new environment** - calling the same outer function twice produces two closures with independent bindings
- Closures can mutate variables in their enclosing environment, and each closure's mutations affect only its own captured environment
- Closures see the **current value** of outer variables when called - if an outer variable is mutated after the closure is created, the closure sees the updated value

# [`lambda3`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **Lambda expressions** create anonymous functions (functions without names).
- **`deffun` is shorthand** for `defvar` + `lambda`:
    
    `(deffun (f x y z) body)` ≡ `(defvar f (lambda (x y z) body))`.
    

# [`post4`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- Closures see the **current value** of outer variables at call time - mutations to outer variables are visible to the closure.
- Variables are not aliased - assignment copies values, not references to bindings.
- Different calls to a function create different closures with independent environments.
- Mutating a parameter doesn't affect the caller's variable.
- Reassigning a variable doesn't affect vectors/closures that already captured the old value.

# [`begin (lispy)`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

- **`begin`** evaluates sub-expressions left-to-right and returns the value of the last expression.
    
    Example: `(begin 2 3 4)` → `4`.
    
- **`if`** requires exactly 3 sub-expressions: condition, then-branch, else-branch - too few or too many is a syntax error.
- Use `begin` to group multiple expressions into a single expression (useful for `if` branches with side effects).
    - `(if cond thn els)` - only one expression per branch allowed.
    - `(if (eq? n 0) 1 (begin (set! x 1) (* n x)))` - use `begin` for multiple expressions.

# [`local (lispy)`](https://script.google.com/a/macros/holistics.io/s/AKfycbxOP4nsl9EXegdBZ9W9JrU-WwwA6ES8u_TSnhJ-NRlw5SVfIOaK8RBocYeIyhjla4bypA/exec)

**`let` basics:**

- Binds variables to values for use within its body
- Bindings are local (not accessible outside the `let`)
- Syntax requires brackets: `([var expr])` not `(var expr)`

**`let` scoping rule:**

- Left-hand-side variables are only in scope within the body
- Right-hand-side expressions cannot reference any of the `let`bound variables
- This means recursive functions and cross-references between bindings won't work

**`letrec` scoping rule:**

- All left-hand-side variables are in scope for all right-hand-side expressions
- Enables recursive and mutually recursive function definitions
- All left-hand-side variable names must be distinct

**`let*` scoping rule:**

- Each left-hand-side variable is in scope for all subsequent right-hand-side expressions
- Allows sequential/chained bindings where later bindings can reference earlier ones
- Same variable name can be rebound multiple times

**Key distinction:**

- `let`: body only.
- `letrec`: all RHS expressions + body.
- `let*`: subsequent RHS expressions + body.

# `mini`

---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Chapter 5. types"
author: Shriram Krishnamurthi
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - language-safety-partiality
  - hindley-milner-system
  - type-inference
  - pattern-matching
  - union-type-retrofitted-type-system
  - if-splitting
  - sum-type-union-type
  - retrofitted-type-system
  - expression-problem
  - nominal-typing-structural-typing
  - subtyping-relation
  - inheritance-subtyping
  - gradual-typing-macro-gradual-typing-micro-gradual-typing
parent: programming-languages-application-and-interpretation
children: []
---

# Introduction to types
:::question
The foundational motivation for studying types.
:::

- What are types?
- Why do types matter in programming language design?

## What are static types?

- **Types**: A fundamental approach to ensuring **program correctness before execution**.
    - Types are a common first step towards **proving properties** about programs
    - When you use a **typed language**, you write small proofs about your programs every day, whether you realize it or not.
- **Static types**: Types that are checked before program execution (at **compile time**).
    - The term **static** means the checking happens purely on the **program source**, without running it.

## Why use types?

- **Guarantees without running**: Types give us assurances without executing the program.
    - Some programs are **expensive to run**, **impossible to reproduce** (e.g., depends on conditions that can't be recreated), or **dangerous**.
    - Types cannot refer to **dynamic conditions** (runtime values) - they work only with static information.
- Types serve as **documentation** that is checked by the compiler.

## The trade-off

- Types may suffer from **false-positive errors**: something in code that can never run in practice may still cause a **type error**.
- Types may suffer from **false-negative errors**: some errors slip through undetected.
- This is the fundamental cost of **static analysis** - we cannot have perfect precision.

**Key insight:** Types **abstract away** runtime details to provide guarantees statically. This abstraction is both powerful and limiting.

# A standard model of types

- A concrete mental model for understanding types.
- Rather than thinking of types abstractly, we can understand them as a specific **computational mechanism** that relates to interpretation.

## Types as abstractions

The key idea: Types simplify the complex world of runtime values.

- **Core idea:** Types are **abstractions of run-time values**.
    - We **collapse distinctions within** value categories: all numbers become `Num`, all strings become `Str`.
    - We **preserve distinctions between** categories: `Num` is different from `Str`.
    - This **collapsing** is both the **strength** and **weakness** of type checking.
- An infinite number of concrete values map to a finite number of **type representatives**.

## From boolean checker to type calculator

- A concrete example showing:
    - **Why** a naive approach fails.
    - **How** to fix it.
    
    → This progression illustrates the **key insight** that **drives type system design**.
    
- A basic interpreter
    
    ```scheme
    #lang plai-typed
    
    (define-type BinOp
      [plus])
    
    (define-type Exp
      [binE (operator : BinOp)
            (left : Exp)
            (right : Exp)]
      [numE (value : number)])
    
    (define (calc [e : Exp]) : Number
      (type-case Exp e
        [binE (o l r)
         (type-case BinOp o
           [(plus) (+ (calc l) (calc r))])]
        [numE (v) v]))
    ```
    

- A **type "checker"**: To pass judgment on programs, i.e., to determine whether or not they are type-correct.

- **First attempt - building up from the interpreter**
    
    Naturally:
    
    ```scheme
    (define (tc [e : Exp]) : boolean
    	...)
    ```
    
    ```scheme
    #lang plai-typed
    
    (define (tc [e : Exp]) : boolean
      (type-case Exp e
        [binE (o l r)
              (type-case BinOp o
                [plus () (and (tc l) (tc r))])]
        [numE (v) #t]))
    ```
    
    → Every program is type-correct.
    
    → Add one more operation: `++` - string concatenation.
    
    **The problem with a naive approach:** A first attempt might be to simply check whether expressions are "well-typed" by returning a **Boolean**. This seems natural but is fundamentally flawed.
    
    ```racket
    ; Naive type checker - just returns Boolean
    (tc : (Exp -> Boolean))
    
    (define(tc e)
      (type-case Exp e
        [(binE o l r)
         (type-case BinOp o
           [(plus) (and (tc l) (tc r))]
           [(++) (and (tc l) (tc r))])]
        [(numE v) #true]
        [(strE v) #true]))
    ```
    
    **Pitfall:** This checker accepts `(++ 5 6)` (concatenating numbers) because it only knows sub-expressions are **well-typed**, not *what types* they have. The `#true` tells us nothing useful about compatibility.
    
- **The solution - type calculator**
    
    The fix is to return the actual **type**, not just a Boolean. This gives us the information needed to check **type compatibility**.
    
    ```racket
    ; Better: returns actual Type
    (tc : (Exp -> Type))
    
    (define-type Type [numT] [strT])
    
    (define(tc e)
      (type-case Exp e
        [(binE o l r)
         (type-case BinOp o
           [plus () (if (and (numT? (tc l)) (numT? (tc r)))
                       (numT)
                       (error 'tc "not both numbers"))]
           [++ () (if (and (strT? (tc l)) (strT? (tc r)))
                     (strT)
                     (error 'tc "not both strings"))])]
        [numE (v) (numT)]
        [(strE (v) (strT)]))
    ```
    
    Now we can verify that `++` receives strings and `+` receives numbers by examining the **returned types**.
    

## Three key takeaways

1. **Same schema as interpreter:** The type checker uses an **algebraic datatype** for the AST and **structural recursion** to process it (the **SImPl pattern**)
2. **Weak values:** The type checker ignores actual values - the `numE` case ignores the **numeric value** entirely and only returns **`numT`**.
3. **Strengthened inductive hypothesis:** Returning `Type` instead of `Boolean` is mathematically a **strengthening** - we replaced `#true` with actual type info and `#false` with an error.

**Rationale:**

- By returning **actual types**, we can check that operations receive the types they expect, not just that sub-expressions are "well-typed" in some vague sense.
- The **inductive hypothesis** is what we assume about recursive calls, and making it stronger gives us more to work with.

# Concise notation for type rules

- Standard mathematical notation used in the programming languages community.
- Appears in research papers, textbooks, and language specifications.
- More concise than code.

## Judgment notation

- $\vdash e : T$ means "e has type T" - this is the fundamental **typing judgment**.
- $\vdash$ is pronounced **"proves"** - it represents a logical derivation.
- $\Gamma \vdash e : T$ means "**environment $\Gamma$ proves** $e$ has type $T$".
- The environment $\Gamma$ (Greek letter **gamma**) tracks **variable bindings**.

**Why this notation?** It's concise, standard in **PL theory**, and maps directly to code. Once you learn it, you can read any type system specification.

## Axioms vs rules

**Axioms** are base cases, while **rules** handle compound expressions.

**Axioms** (base cases - no premises needed):

Axioms are unconditional statements that require no proof. They represent the **ground truth** of the type system.

$$
\begin{aligned}
\vdash & & n & : \text{Num} & \text{ (for all numeric literals $n$)} \\
\vdash & & s & : \text{Str} & \text{ (for all string literals $s$)} \\
\vdash & & \text{true} & : \text{Bool} \\
\vdash & & \text{false} & : \text{Bool}
\end{aligned}
$$

**Rules** (conditional cases - have premises):

Rules have **conditions** that must be satisfied before the **conclusion** can be drawn. They represent the **inductive cases**.

$$
\dfrac{\vdash e_1 : \text{Num} \quad \vdash e_2 : \text{Num}}{\vdash (+ \; e_1 \; e_2) : \text{Num}}
$$

**Reading rules:**
- Space between premises means **"and"** - all must hold.
- **Antecedent:** part above the line (what must be true first).
- **Consequent:** part below the line (what we can conclude).

**Pitfall:** Don't call these "numerator" and "denominator" - they're **antecedent** and **consequent**! This is logic, not fractions.

## Judgments and type errors

**A judgment** is a complete **derivation tree** where:

- Every antecedent is generated using given rules.
- All leaves are actual **axioms**.
- The tree is fully "checked off" - no gaps remain.

**A type error** = failure to construct a judgment. There's no rule that applies, so we can't complete the tree.

**Example of successful judgment:**

$$
\dfrac{\vdash 5 : \text{Num} \quad \dfrac{\vdash 6 : \text{Num} \quad \vdash 7 : \text{Num}}{\vdash (+ \; 6 \; 7) : \text{Num}}}{\vdash (+ \; 5 \; (+ \; 6 \; 7)) : \text{Num}}
$$

**Example of type error:**

$$
\dfrac{\vdash 5 : \text{Num} \quad \dfrac{\vdash 6 : \text{Num} \quad \underbrace{\vdash \text{"hi"} : \textbf{???}}_{\text{No rule makes "hi" : Num}}}{\vdash (+ \; 6 \; \text{"hi"}) : \textbf{???}}}{\vdash (+ \; 5 \; (+ \; 6 \; \text{"hi"})) : \textbf{???}}
$$

**Key insight:** **Type errors** manifest as inability to complete the tree - there's no rule that applies to justify the required typing.

# Handling division and partial functions

This section addresses a fundamental issue: not all operations are defined for all inputs. How should a type system handle **partiality**?

## The problem

**Division by zero** is the classic example of partiality, but the problem is general.

- Addition, multiplication, and subtraction are **total functions** over numbers - always produce a result.
- Division is a **partial function**: undefined when **denominator is zero**.
- The type system must have a strategy for handling this **partiality**.

## Three strategies

This subsection presents the design space. Each approach has different trade-offs between **convenience**, **safety**, and **burden on programmers**.

|  Strategy  | Approach |  Burden  |
|  ---  | --- |  ---  |
|  **Option type**  | Return `(Optionof Number)` |  Every use must check for valid result  |
|  **Refined types**  | Require **non-zero** second argument |  Callers must prove non-zero  |
|  **Exception**  | Same type, handle exceptional case with **error** |  Rest of program must handle possibility  |

**Most languages use strategy 3** - it's **pragmatic** but pushes burden to runtime.

**Why strategy 2 is hard:**

- Proving a value is non-zero is **undecidable** (**Rice's Theorem** tells us we cannot automatically determine arbitrary properties of program values).
- The type checker would need **programmer help** via annotations or proofs.

**Connection:** This foreshadows the fundamental tension between **type system expressiveness** and **decidability**. We can't have everything.

A growing number of languages are exploring the first two options.

- Get around Rice's Theorem in the second case by trying to prove non-zero-ness and, when they cannot, putting the burden on the programmer.
- While this creates more effort for the programmer, it increases the program's robustness.

## Another perspective on types

- An alternative conceptual framework for understanding:
    - What types are.
    - How they relate to other static analyses we already know.
- **Two perspectives on types:**
    
    
    |  Perspective  | Description |  Analogy  |
    |  ---  | --- |  ---  |
    |  **Abstraction of values**  | Types are **simplified representations** of runtime values; type-checking is like running a program over these **abstract values**. |  Type checker as "abstract interpreter"  |
    |  **Static discipline**  | Types are a way of statically making **judgments** about programs - deciding which programs are "good" and which are "bad" **before they run**. |  Type checker as "extended parser"  |

**Important caveat:** The **"abstraction of values"** analogy will **break down** as we explore more complex type systems. The two perspectives are complementary but not equivalent.

**Connection to parsing:** The Static discipline perspective reveals that we've already been doing something similar: **parsing**.

- A **parser** statically (before the program runs) passes **judgment** on programs.
- It decides some programs are **syntactically valid** and others are **invalid**.
- Types extend this idea to make **more sophisticated judgments** about program correctness.
- Both are forms of **static analysis** - examining programs without executing them.

**Why separate parsing and type-checking into two phases?**

Computation theory provides the answer through the Chomsky hierarchy:

|  Phase  | Constraint type |  Complexity  | Example checks | 
 | --- |  ---  | --- |  ---  |
|  **Parsing**  | **Context-free** |  Less complex (CFG)  | Balanced parentheses, syntax structure | 
 | **Type-checking** |  **Context-sensitive**  | More complex (CSG) |  Variable declared before use, type compatibility  |

**Benefits of separation:**

- **Reduced complexity:** The type checker only processes programs that **already passed parsing** - it receives well-formed `Expr` ASTs, not raw text.
- **Cleaner error messages:** Syntax errors are reported by parser; type errors by type checker.
- **Simpler implementation:** Each phase has a **focused responsibility**.
- **Theoretical foundation:** Context-free checks are **decidable** with efficient algorithms (polynomial time); doing everything at once would be harder.

**Concrete example from our type checker:**

```racket
; Our type checker consumes Expr, NOT raw strings
(tc : (Expr -> Type))
```

The type checker **assumes** its input is a valid `Expr` - the parser has already done the work of:

- Tokenizing the input.
- Building the AST.
- Rejecting malformed syntax.

**Key insight:** The **two-phase design** (parse first, then type-check) is a principled **separation of concerns** based on **computability theory**. Each phase handles constraints at its appropriate complexity level, making the overall system simpler and more maintainable.

# Typing conditionals

## The typing rule

$$
\dfrac{\vdash C : \text{Bool} \quad \vdash T : U \quad \vdash E : U}{\vdash (\text{if} \; C \; T \; E) : U} \; \small{\text{(T-If)}}
$$

**Key elements:**
- `C` must be `Bool` (no **truthy/falsy** - we require actual Booleans).
- `U` is a **placeholder** (also called a **type variable** or **metavariable**).
- **Same `U` in both branches** ensures they have **identical types**.
- The result type is `U` - whatever the branches produce.

**Why require same types?** This eliminates **uncertainty** about what type the conditional produces. Alternative approaches exist (union types, subtyping) but add complexity.

## How placeholder matching works

This subsection works through concrete examples showing how the **placeholder `U`** gets instantiated during type checking.

**Example 1 - Success:**

```racket
(if true 1 2)
```

- Check `true : Bool` (axiom for Booleans)
- Check `1 : U` \to U must be **Num** (axiom for numbers)
- Check `2 : U` \to U is **Num** (consistent!)
- Result: `Num`

**Example 2 - Failure:**

```racket
(if true 1 "hi")
```

- Check `true : Bool` 
- Check `1 : U` \to U must be **Num**
- Check `"hi" : U` \to U must be **Str**
- **Conflict!** U cannot be both Num and Str - **no solution exists**

**Rationale for same-type branches:** This design eliminates uncertainty about result type. The alternative is **union types** (discussed later), which add complexity.

### Exercise

**Statement**. Let's now add functions. We need two new constructs: one to introduce them (lambda) and one to use them (function application). Write down judgments for each. Hint: You may need to revisit the set of types, too.

<details>

<summary>Solution</summary>



- Functions require two constructs: **lambda** (introduction) and **application** (elimination).
- Current types are insufficient - functions are not numbers, strings, or booleans. Add Arrow type:

$$
\text{Type} = \text{Num} \mid \text{Str} \mid \text{Bool} \mid (\text{Type} \rightarrow \text{Type})
$$

- **Lambda** $(\text{lambda} \ t_1 : T \ t_2)$ - parameter $V$ with annotation $T$, body $B$:

$$
\frac{\Gamma[t_1 : T ] \vdash t_2 : U}{\Gamma \vdash (\text{lambda} \ t_1 : T \ t_2) : (T \rightarrow U)}
$$

- **Application** $(t_1 \ t_2 )$ - function $t_1$ applied to argument $t_2$:

$$
\frac{\Gamma \vdash t_1 : (T \rightarrow U) \quad \Gamma \vdash t_2 : T}{\Gamma \vdash (t_1 \ t_2) : U}
$$




Because `let` desugars into `lambda`, once we have this, in principle we also have a conditional rule for `let`.

</details>

### Exercise

**Statement**. Add desugaring to the type-checker.

<details>

<summary>Solution</summary>



$$
\frac{\Gamma \vdash (\text{lambda}\ x: T\ t_2) : (T \rightarrow U) \quad \Gamma \vdash t_1 : T}{\Gamma \vdash (\text{let}\ [x\ t_1]\ t_2) : U}
$$




In reality, this is more complex: **Inferring Type Rules for Syntactic Sugar**.

</details>

# Where types diverge from evaluation

This section highlights a crucial difference between **type checking** and **evaluation**. Understanding this difference is essential for understanding both the power and limitations of type systems.

## The critical difference

This subsection directly compares how evaluators and type checkers handle the same code. The difference has profound implications.
|   Aspect  |  Evaluator |   Type checker  |
|   ---  |  --- |   ---  |
|   Branches visited  |  Only the **taken branch** |   **Both branches**  |
|   When  |  At **runtime** with specific values |   **Statically**, before runtime  |
|   Coverage  |  Depends on inputs |   Always **complete**  |
**Example:**

```racket
(if true 1 "hi")
```

- **Evaluator:** Only evaluates `1`, program runs fine (else branch never examined)
- **Type checker:** Checks both `1` and `"hi"`, rejects program (both must have same type)

- The type checker must be **conservative** because it can't know which branch will execute.
    
    Consider this more realistic example:
    
    ```racket
    (if (is-full-moon) 1 "hi")
    ```
    
    **Questions the type checker cannot answer:**
    - What is the **moon's phase** at type-checking time?
    - What will it be at **execution time**?
    - The program might run **many times** over many months
    

**Conclusion:** Type checker must be **conservative** - it considers **all possible executions**, not just one. This is why it checks both branches.

## Connection to testing

This subsection relates type checking to software testing, showing how they are **complementary** approaches to correctness.
|   Approach  |  Coverage |   Depth  |
|   ---  |  --- |   ---  |
|   **Testing**  |  Partial (hard to cover all branches) |   Deep (actual values)  |
|   **Type checking**  |  Complete (all branches) |   Shallow (types only)  |
**Branch coverage** is important in testing but difficult to achieve. Type checking provides it automatically, but only at the **type level**.

**Concolic testing** ("**concrete**" + "**symbolic**") tries to get best of both worlds by combining concrete execution with symbolic reasoning.

**Key insight:** Testing and type checking are **complementary**, not competing approaches. Use both for maximum assurance.

# Typing function applications

This section addresses how to type **function calls** (applications). This is essential because functions are fundamental to programming, and getting their types right is crucial for a useful type system.

## Function types use arrow notation

This subsection introduces the Arrow type notation, which is standard across programming languages and PL theory.

- $T \to U$ means "**function from $T$ to $U$".
- $T$** is the **parameter type** (input).
- **$U$** is the **return type** (output).
- The **$\to$** is a **type constructor** (it's **two-place**: takes two types, produces a function type).
- The arrow notation suggests **implication**: "if you give me a **$T$, I'll give you a $U$**".

## The application rule

This subsection presents the typing rule for function application and explains each component.

$$
\dfrac{\Gamma \vdash t_1 : (T \to U) \quad \Gamma \vdash t_2 : T}{\Gamma \vdash (t_1 \; t_2) : U}
$$

**Reading this rule:**

1. **Type-check function**: Ensure it's a **function type** $T \to U$.
2. **Type-check argument**: Ensure argument matches **parameter type** $T$.
3. **Compute result**: If both hold, result type is **return type** $U$.

## Type errors in application

This subsection shows how type errors manifest in function calls. Understanding these errors helps with debugging.

```racket
(define f: (Number -> String) ...)
(f "hello")  ; Error: expected Number, got String
```

The rule fails because we cannot find a $T$ where both:
- $f : (T \to U)$ ( $T$ must be **Number** from $f$'s definition).
- $\text{"hello"} : T$ ($T$ must be **String** from the argument).

These are **inconsistent**, so no judgment exists.

# Typing function definitions (lambda)

This section addresses how to type **function definitions**. This is the counterpart to function application - together they form the complete story of function typing.

## The challenge

This subsection explains why typing function definitions is harder than it might seem at first.

```racket
(lambda x x)  ; What is the type of x?
```

**Problem:** We don't know what type $x$ should have! There's no information in the code telling us.

**Pitfall:** The **formal parameter** $x$ in $(\text{lambda}\ x\ t)$ is a **literal name**, not an expression. We cannot **evaluate** it (would cause **unbound variable error**). It only has meaning inside the function body.

## Solution: type annotations

This subsection introduces the need for **programmer-provided type information**. This is why typed languages require annotations.

Extend syntax to require annotations:

```racket
(lambda x : T t)  ; x expects type T in body y
```

**Why annotations are needed:**
1. **Type checker** needs to know expected type to check the body.
2. **Documentation benefit:** Better communicates **function contract** to users and maintainers
3. Without annotations, we need **type inference** (covered later), which has its own trade-offs.

## The lambda rule

This subsection presents the formal typing rule and explains how it works.

$$
\dfrac{\Gamma[x \leftarrow T] \vdash t : U}{\Gamma \vdash (\text{lambda} \; x : T \; t) : (T \to U)}
$$

**Reading this rule:**
1. **Extend environment** with $x$ bound to $T$.
2. **Type-check body** $T$ in extended environment, get type $U$.
3. **Whole function** has type $(T \to U)$.

**Key details:**
- $\Gamma[x \to T]$ means "$\Gamma$ **extended with $x$ bound to $T$**".
- Uses environment of **function definition** (**static scope**!).
- **Annotation $T$** becomes **parameter type** in result.
- **Body type $U$** becomes **return type** in result.

# Type environments

This section explains **type environments**, which track type information for variables. Environments are essential for typing any language with variable bindings.

## What is a type environment?

This subsection defines the concept and explains its role in type checking.

- **Type environment ($\Gamma$):** A **mapping** from variable names to types.
- Similar to **value environment** in interpreter, but maps to **types** instead of **values.**
- **Passed recursively** through type checking, just like value environments in interpretation.
- The Greek letter **gamma ($\Gamma$)** is the conventional name for type environments.

## Typing variables

This subsection explains how variables get their types. It's surprisingly simple once you have environments.

$\Gamma \vdash v : \Gamma(v)$

**Translation:** "The type of variable `v` is whatever the **environment** says it is".

This is an **axiom** - no premises needed. We just look up the variable in the environment.

## Environment extension

This subsection explains how environments grow when new bindings are introduced.

- $\Gamma[x \leftarrow T]$ = "$\Gamma$ **extended with** $x$ **bound to** $T$".
- Same operation as **value environment extension** in interpreters.
- Used when entering scope of new binding (**lambda**, **let**, etc.).
- The new binding may **shadow** an existing one with the same name.

**Connection:** This mirrors how interpreters handle **variable binding** - type checkers just track **types** instead of **values**. The structural similarity is not coincidental; types are abstractions of values.

# More divergence: function definitions vs applications

This section explores another important difference between type checking and evaluation, specifically for functions. This difference explains why type checking can **terminate** even for programs that would run forever.

## Evaluation vs type checking of functions

This subsection directly compares the two approaches to handling function bodies.
|   Aspect  |  Evaluator |   Type checker  |
|   ---  |  --- |   ---  |
|   When body is visited  |  **Every application** (possibly \infty) |   Only at **definition** (exactly once)  |
|   What's used  |  Specific **argument value** |   Abstract **type annotation**  |
|   Termination  |  May **loop forever** |   **Guaranteed to terminate**  |
## Why type checking terminates

This subsection explains the deep reason for this important property.

- **Evaluator** needs specific values, so must re-run body **each time** with new arguments.
- **Type checker** uses **abstract values** (types) - **one pass** through the body suffices.
- At application, type checker doesn't know *which* function - only its **type**.
- All communication happens through **type boundary** (the function type signature).

**Key insight:** **Abstraction enables termination**. By ignoring **concrete values**, type checker avoids **infinite recursion** that can happen in evaluation.

## The abstraction trade-off

This subsection explains what we give up for this termination guarantee.

We collapse infinite sets of values into finite types:

- Infinite strings \to `Str`.

- Infinite numbers \to `Num`.

- Infinite `(Num -> Num)` functions \to `(Num -> Num)`.

**Both strength and weakness:** We lose **precision** (can't distinguish different numbers) but gain **decidability** (guaranteed to terminate with an answer).

# Assume-guarantee reasoning

This section introduces a fundamental pattern in type system design. **Assume-guarantee reasoning** appears throughout programming languages and is essential for understanding how components interact safely.

## The pattern

This subsection shows the pattern concretely using function rules we've already seen.

$$
\dfrac{\Gamma[x \leftarrow T] \vdash t : U}{\Gamma \vdash (\lambda \; x : T \; t) : (T \to U)} \; \small{\text{(Lambda)}}
\\
\dfrac{\Gamma \vdash t_1 : (T \to U) \quad \Gamma \vdash t_2 : T}{\Gamma \vdash (t_1 \; t_2) : U} \; \small{\text{(Application)}}
$$

**The dance between rules:**

|  Rule  | Assumes |  Guarantees  |
|  ---  | --- |  ---  |
|  **Lambda**  | Parameter has type **T** |  Body produces type **U**  |
|  **Application**  | Function `(T -> U)` produces **U** when given **T** |  Argument has type **T**  |

## Why arrow means implication

This subsection explains the logical interpretation of function types.

- `(T -> U)` can be read as "giving **T implies** producing **U**"
- This is **mathematical implication**!
- **Lambda** proves this implication (shows the body works)
- **Application** relies on it (uses the guarantee)

**This pattern appears everywhere** in type systems - look for it in other rules. Whenever two rules interact, **one typically assumes what the other guarantees**.

# Recursion and infinite loops

This section addresses a deep question: can we write **infinite loops** in a typed language? The answer reveals surprising connections between types and Computability.

## Can we write infinite loops without recursion?

This subsection shows that infinite loops are possible through self-application, which has implications for typing.

**The Divergent/Big omega combinator:**

```racket
(let ([\omega (lambda (x) (x x))])
  (\omega \omega))
```

This runs **forever** in untyped Racket! The function `\omega` applies its argument to itself, and `(\omega \omega)` creates infinite self-application.

## Why it can't be typed

This subsection explains why self-application creates a **type impossibility**.

To type `(x x)`:
- `x` is in **function position** \to type must be `(T -> U)` for some T, U
- `x` is the **argument** \to type must be `T`
- So we need: `T = (T -> U)`

**No finite type satisfies this equation!** The type would need to be infinitely nested: `(((...) -> U) -> U) -> U`.

Each application "**uses up an arrow**". **Finite program text** = finite arrows = must terminate.

## Simply Typed Lambda Calculus (STLC)

This subsection introduces an important theoretical language and its properties.

**Property:** **Strong normalization** - **all programs terminate.**

**Seems useless?** Actually valuable for many domains where **termination is required**:

- **Network packet filters** - must process packets quickly.
- **Device drivers** - can't hang the operating system.
- **Compilers** - must eventually produce output.
- **Type checkers themselves** - must terminate.
- **Module linking** (Standard ML's module language built on STLC).

**Reactive systems pattern:** Many real systems combine termination with infinite behavior:

- Infinite loop **"spine"** (generic, keeps system responsive).
- Terminating **"ribs"** (specific computations that complete).
- Web apps, GUIs, OS with drivers all follow this pattern.

**Profound insight:** Adding types can change **expressive power** of a language. Types are "**semantic**", not just **syntactic convenience**.

## Adding recursion with `rec`

This subsection shows how to add recursion back to obtain a practical programming language.

```racket
(rec fact : (Number -> Number)
  (lambda (n) (if (zero? n) 1 (* n (fact (- n 1)))))
  (fact 10))
```

**The `rec` typing rule:**

$$
\dfrac{\Gamma[x \leftarrow T] \vdash t_1 : T \quad \Gamma[x \leftarrow T] \vdash t_2 : U}{\Gamma \vdash (\text{rec} \; x : T \; t_1 \; t_2) : U} \; \small{\text{(T-Rec)}}
$$

**Compare to `let`:**

$$
\dfrac{\Gamma \vdash t_1 : T \quad \Gamma[x \leftarrow T] \vdash t_2 : U}{\Gamma \vdash (\text{let} \; x : T \; t_1 \; t_2) : U} \; \small{\text{(T-Let)}}
$$

**Key difference:** In `rec`, **both $t_1$ and $t_2$** are typed in the **extended environment**!

**How recursion works:**

- Extended environment for **$t_2$** **initiates** recursion (**$t_2$ can call $x$).
- Extended environment for $t_1$** **sustains** it (**$t_1$** can reference itself).
- **Annotation $T$** provides the "**infinite quiver**" of arrows.

**Pitfall:** Cannot obtain recursion through **desugaring** alone - need **special construct** in the language.

# Safety and soundness

This section addresses the **runtime behavior** of typed programs. What guarantees do types provide when the program actually runs? This connects static checking to dynamic execution.

## What is safety?

This subsection defines the concept of language safety, which is distinct from type safety.

**Safety** means:

- Operations are **partial** over the set of all values (not defined for all inputs).
- Language **reports violations** (rather than silently misbehaving or crashing mysteriously).

Examples of **partial operations**:

- `+` only works on **numbers** (not strings or functions).
- **Function application** requires function in first position.
- **Array access** requires valid index.

## Unsafe language example

This subsection shows concretely what an **unsafe language** looks like. This is essentially the **C memory model**.

**Memory as raw vector:**

```racket
(define MEMORY (make-vector 100 -1))
(define next-addr0)

(define (store-num n)
  (let ([a (next-addr)])
    (begin (vector-set! MEMORY a n)
           (set! next-addr (add1 next-addr))
           a)))  ; Return address, not value!

(define (read-num a)
  (vector-ref MEMORY a))  ; Just read whatever is there

(define (store-str s)
  (let ([a0 (write-and-bump (string-length s))])
    (begin (map write-and-bump (map char->integer (string->list s)))
           a0)))
```

**The horror - data has no integrity:**

```racket
> (read-num (calc (cat (num 1) (str "hello"))))
6  ; Garbage! Interpreted string length as number

> (read-str (calc (plus (num 1) (str "hello"))))
. . integer->char: contract violation  ; Crash!
```

**This is the memory model of C** - data has **no integrity**, any value can be **treated as any type**. This leads to **security vulnerabilities**, **crashes**, and **mysterious bugs**.

## Recovering safety with tags

This subsection shows how to make the language safe by adding [Runtime type information (RTTI)](/journeys/plt/concepts/runtime-type-information-rtti).

**Add metadata to each value:**

```racket
(define NUMBER-TAG 1337)
(define STRING-TAG 5712)

(define (store-num n)
  (let ([a0 (write-and-bump NUMBER-TAG)])  ; Write tag first
    (begin (write-and-bump n)
           a0)))

(define (safe-read-num a)
  (if (= (vector-ref MEMORY a) NUMBER-TAG)
      (vector-ref MEMORY (add1 a))
      (error 'number "not a number")))
```

**Memory layout with tags:**

```
Address:  0     1   2   3   4   5   6   7
Content: 5712   5  104 101 108 108 111  -1
         \uparrowtag  \uparrowlen \uparrow'h' \uparrow'e' \uparrow'l' \uparrow'l' \uparrow'o'
```

The **tag** tells us how to interpret the following bytes. **Safety checks** verify the tag before interpreting data.

## The cost of safety

This subsection quantifies the overhead of runtime safety checks.

|  Dimension  | Cost | 
 | --- |  ---  |
|  **Time**  | Safety checks on every operation | 
 | **Space** |  Tags stored with every value  |

**But:** Cost of **unsafe languages** (security vulnerabilities, crashes, debugging time) is usually **much higher** than these overheads.

## Type soundness

This subsection presents the formal property that connects static types to runtime behavior. This is the **central theorem** of type system design.

**Soundness property:**

```
If e : t then
  if e -> v, then v : t
```

**In words:** If type checker says expression has type $T$, and expression evaluates to value $v$, then $v$ **actually has type** $T$.

**Why this matters:**

- Type checker's **prediction is reliable**.
- **No type violations** at runtime.
- **Can safely run on unsafe evaluator** (skip runtime checks for performance!).

**Pitfall:** Soundness must be **formally proven**. Claiming it holds when it doesn't = **security vulnerability**.

**Consequences of unsoundness:**

- **Uncaught exceptions** that slip past the type checker.
- **Crashes**, **segmentation faults**.
- **Security attacks** exploiting the gap between types and reality.

## Generic printing

This subsection shows a practical benefit of tags: we can inspect values without knowing their static type.

Tags enable Runtime type dispatch:

```racket
(define(generic-read a)
  (let ([tag (vector-ref MEMORY a)])
    (cond
      [(= tag NUMBER-TAG) (number->string (safe-read-num a))]
      [(= tag STRING-TAG) (safe-read-str a)]
      [else (error 'generic-print "invalid tag")])))
```

Without knowing **static type**, we can determine **value type** at runtime. This is how **debuggers** and **REPLs** work.

## Number representation optimization

This subsection shows a clever trick used in real language implementations to avoid heap allocation for common values.

**Problem:** Storing every number on heap is **wasteful** - numbers are used constantly.

**Clever trick using alignment:**

- Modern machines use **word-aligned addresses** (multiples of 4 or 8).
- All valid addresses end in `...00` (binary).
- Other bit patterns are **available** for tagging!

**Solution:**

- `...01` pattern = **number tag**.
- Actual number stored in remaining **30 bits**.
- Numbers **never touch the heap**.

```
"Address" 0b...11010101:
- Last two bits: 01 (number tag)
- Shift right 2: actual number value
```

**Benefits:**

- **Zero heap allocation** for small numbers.
- Same-value numbers have **identical representation**.
- **Constant-time equality** comparison.

**Limitation:** Only works for numbers fitting in 30 bits (or ~60 on 64-bit). **Larger numbers** (bignums) still need heap.

# Type inference

This section introduces **automatic type determination**, where the type checker figures out types without programmer annotations. This is one of the most impressive features of modern type systems.

## The goal

This subsection shows what type inference accomplishes through examples.

Determine types **without annotations:**

```racket
> (lambda (x y) (if x (+ y 1) (+ y 2)))
- (Boolean Number -> Number)  ; Inferred automatically!
```

The programmer writes **no type annotations**, yet the type checker determines the **precise type** of the function.

## The Hindley-Milner algorithm

This subsection introduces the classical algorithm for type inference, used in **ML**, **OCaml**, **Haskell**, and many other languages.

**Two phases:**

1. **Constraint generation:** Walk AST, generate **type equations** based on how variables are used.
2. **Constraint solving:** Solve equations like "**systems of simultaneous equations**" from algebra.

**Unique variable names assumption:** All variables have **unique names** throughout program. Use Alpha conversion/renaming (renaming) to achieve this if needed. This simplifies the presentation significantly.

## Inference by example

This subsection walks through a concrete example showing how constraints are generated and solved.

```racket
(lambda (x y) (if x (+ y 1) (+ y 2)))
```

**Constraints from `if`:**
- `x` in **conditional position** \to x : **Bool** (if requires Boolean condition)

**Constraints from `(+ y 1)`:**
- `y` in addition \to y : **Num** (+ requires numbers)
- `1` in addition \to 1 : **Num** (axiom)
- Result: **Num**

**Constraints from `(+ y 2)`:**
- `y` in addition \to y : **Num** (consistent with above!)
- Result: **Num**

**Both branches return Num** \to function returns **Num**

**Solution:** `(Bool Num -> Num)`

## Type errors in inference

This subsection shows how **conflicting constraints** lead to type errors.

```racket
(lambda (x) (if x (+ x 1) (+ x 2)))
```

**Constraints:**
- From `if`: x : **Bool** (used as condition)
- From `+`: x : **Num** (used in addition)

**No solution exists!** x cannot be both Bool and Num. The constraints are **inconsistent**.

## Error reporting challenge

This subsection addresses a practical difficulty with inference: **vague error messages**.

**Pitfall:** Without annotations, we can't pinpoint "**the**" error location.

With annotation `x : Bool`:
- Error is clearly at `(+ x 1)` - using **Bool** in addition

Without annotation:
- Is the error in `if` (should use **different condition**)?
- Or in `+` (should use **different operation**)?
- **Must report all locations** and let programmer decide

**Trade-off:** Inference saves **annotation effort** but produces **vaguer error messages**. This is why many languages still encourage annotations for documentation.

# Algebraic datatypes

This section introduces a powerful mechanism for defining **custom data structures** with **multiple variants**. Algebraic datatypes are fundamental to typed functional programming.

## What is an algebraic datatype?

This subsection defines the concept and its components.

```racket
(define-type BT
  [mt]
  [node (v : Number) (l : BT) (r : BT)])
```

**Three features bundled:**

|  Feature  | Example |  Purpose  |
|  ---  | --- |  ---  |
|  **Named type**  | `BT` |  Can reference in annotations, creates new type  |
|  **Multiple variants**  | `mt`, `node` |  "Or" - BT is **either** mt **or** node  |
|  **Recursive definition**  | `l : BT`, `r : BT` |  Enables trees, lists, etc.  |

**Why bundle them?**
- **Recursion needs a name** (for self-reference in type).
- **Recursion needs base case** (non-recursive variant to "bottom out").
- They naturally work together in practice.

**Terminology:**
- **Algebraic datatype:** The whole definition.
- **Sum of products:** Variants are "**or**" (sum), fields are "**and**" (product).
- **Tagged union:** Each variant has a **tag** (constructor name) distinguishing it.

## Generated bindings

This subsection lists what a datatype definition creates.

```racket
; Constructors - create values
(mt : (-> BT))
(node : (Number BT BT -> BT))

; Predicates - test which variant
(mt? : (BT -> Boolean))
(node? : (BT -> Boolean))

; Accessors - extract fields
(node-v : (BT -> Number))
(node-l : (BT -> BT))
(node-r : (BT -> BT))
```

## The accessor problem

This subsection shows a critical flaw with exposing raw accessors.

**Pitfall - unsafe accessors:**

```racket
(define(size-wrong (t : BT))
  (+ 1 (+ (size-wrong (node-l t)) (size-wrong (node-r t)))))

(size-wrong (mt))  ; Type-checks but crashes!
```

**Why this type-checks:**

- `node-l : (BT -> BT)` - accepts any BT
- `t : BT` - t is a BT
- Types match!

**Why it crashes:**

- `mt` has **no `l` field**.
- Accessor fails at **runtime** - the very error types should prevent!

**Root cause:** Type `BT` is **too coarse** - doesn't distinguish variants. The type `BT` includes both `mt` and `node`, so the type checker can't know which we have.

## Pattern-matching solution

This subsection shows the proper way to deconstruct algebraic datatypes safely.

```racket
(define(size-pm t)
  (type-case BT t
    [(mt) 0]
    [(node v l r) (+ 1 (+ (size-pm l) (size-pm r)))]))
```

**How pattern matching helps:**
- `type-case` is **baked into type checking** - not a library function.
- In `node` branch, `v`, `l`, `r` **automatically have correct types**.
- **No unsafe accessors** exposed to programmer.
- **Cannot accidentally use `l` in `mt` branch** - it simply doesn't exist there!

**The generated typing rule:**

$$

\dfrac{\begin{array}{c} \Gamma \vdash e : \text{BT} \quad \Gamma \vdash e_1 : T \\ \Gamma[v \leftarrow \text{Num}, l \leftarrow \text{BT}, r \leftarrow \text{BT}] \vdash e_2 : T \end{array}}{\Gamma \vdash (\text{type-case} \; \text{BT} \; e \; [(\text{mt}) \; e_1] \; [(\text{node} \; v \; l \; r) \; e_2]) : T} \; \small{\text{(T-Case-BT)}}

$$

Pattern matching enables the type checker to **refine** the type in each branch.

## Space considerations

This subsection addresses runtime representation efficiency.

|  What  | Tags needed? | 
 | --- |  ---  |
|  Between **types**  | No (type checker distinguishes at compile time) | 
 | Between **variants** |  Yes (runtime needs to know which variant)  |

**Variant tag size:** log_2(number of variants) bits - usually very small. A type with 4 variants needs only 2 bits for the tag.

# Union types

This section introduces an alternative to algebraic datatypes that **combines existing types** rather than defining new variants. Union types are common in **retrofitted type systems**.

## Motivation

This subsection explains when union types are useful.

**Problem:** What if types **already exist** and we want to combine them?

With algebraic datatypes, variants are "**owned**" by the type - they're defined together. With **union types**, we combine **independent types** that already exist separately.

## Defining with union types

This subsection shows the syntax and semantics.

```racket
#lang typed/racket

(struct mt ())
(struct node ([v : Number] [l : BT] [r : BT]))
(define-type-alias BT (U mt node))  ; Union of existing types
```

**Key difference from algebraic datatypes:**

- `mt` and `node` are **independent types first** - they exist on their own.
- `BT` is defined as their **union afterward** - a combination.
- **Untagged union:** No special constructors for the union itself.

## Predicate types

This subsection explains how predicates work with union types.

```racket
> mt?
- : (-> Any Boolean : mt)
         \uparrow            \uparrow
      Takes any    When true, input was mt
```

The `: mt` annotation is crucial - it tells the type checker what the predicate **proves** about its input when it returns true.

## If-splitting (occurrence typing)

This subsection explains the key mechanism that makes union types usable.

```racket
(define(size-tr [t : BT]) : Number
  (cond
    [(mt? t) 0]                              ; t : mt here
    [(node? t) (+ 1 (size-tr (node-l t)))   ; t : node here
               (size-tr (node-r t)))]))
```

**How it works:**

1. `t` starts with type `BT` (**union** of `mt` and `node`)
2. After `(mt? t)` returns **true**, type **narrows** to just `mt`
3. After `(node? t)` returns **true**, type **narrows** to just `node`
4. In `node` branch, `node-l` is **safe** because `t : node`

**Also called:** **Occurrence typing**, **flow typing** - the type of a variable changes based on where it occurs in control flow.

## If-splitting failures

This subsection shows what happens when if-splitting can't help.

**Without predicate:**

```racket
(define(size-tr-wrong [t : BT]) : Number
  (+ 1 (size-tr (node-l t)) (size-tr (node-r t))))
; Error: node-l expects node, got BT
```

No predicate = no narrowing = **full union type** remains.

**With wrong predicate:**

```racket
(define(size-tr-w2 [t : BT]) : Number
  (cond
    [(node? t) 0]
    [(mt? t) (+ 1 (size-tr-w2 (node-l t)) ...)]))
; Error: node-l expects node, got mt
```

Swapped predicates = **wrong narrowing** = type error detected.

## Introducing union types

This subsection shows how union types are created, not just consumed.

**New conditional rule:**

$$
\dfrac{\Gamma \vdash b : \text{Bool} \quad \Gamma \vdash t_1 : T_1 \quad \Gamma \vdash t_2 : T_2}{\Gamma \vdash (\text{if} \; b \; t_1 \; t_2) : (\text{U} \; T_1 \; T_2)}
$$

Branches can have **different types** \to result is **union**.

**Connection:** **If-splitting eliminates** unions, **conditionals can introduce** them. They are inverses.

## Union types: flexibility vs complexity

This subsection discusses the trade-offs of union types.

**Advantage:** Same type can participate in **multiple unions**.

```racket
(define-type-alias BT (U mt node))
(define-type-alias LinkedList (U mt link))  ; mt reused!
```

An `mt` value can be treated as either a `BT` or a `LinkedList` depending on context.

**Disadvantage:**

- Harder to **infer types** (which union is intended?).
- Need **type tags at runtime** (not just variant tags).
- More **space overhead** than algebraic datatypes.

# If-splitting with control flow

This section shows how **if-splitting** scales to more complex control flow patterns found in real code. Real programs don't just have simple if-then-else.

## Real-world complexity

This subsection presents a challenging example from JavaScript.

**JavaScript serializer:**

```jsx
function serialize(val) {
  switch (typeof val) {
    case "undefined":
    case "function": return false;
    case "boolean": return val ? "true" : "false";
    case "number": return "" + val;
    case "string": return val;
  }
  if (val === null) { return "null"; }
  // ... object handling
}
```

**Challenges for type checker:**

- Understand `typeof` **semantics** (what each case means).
- Handle **fall-through behavior** (undefined and function share code).
- Return type is `(String U Boolean)` - need **union**.
- Object handling is **even more complex**.

## State changes and control flow

This subsection shows an even trickier pattern involving **mutation**.

**Python example:**

```python
def insort_right(a, x, lo: int = 0, hi: Optional[int] = None):
    if hi is None:
        hi = len(a)    # hi becomes int!
    while lo < hi:     # hi guaranteed int here
        mid = (lo+hi)//2
        ...
```

**Why this is safe:**

- `hi` starts as `Optional[int]` = `(int U None)`.
- After `if hi is None` with **assignment**, `hi` is definitely `int`.
- Type checker must track **state changes** through control flow.

**This is hard!** Requires sophisticated **flow analysis** that tracks not just branches but also assignments.

# Retrofitted type systems

This section addresses the practical challenge of adding types to **existing untyped languages**. This is increasingly important as dynamic languages mature.

## What is retrofitting?

This subsection defines the concept and its motivation.

**Retrofitted type system:** Adding types to a **previously untyped language**.

**Examples:**

- **TypeScript**, **Flow** \to JavaScript.
- **Static Python** \to Python.
- **Typed Racket** \to Racket.

**Motivation:** Dynamic language codebases grow large and hard to maintain. Types help with **documentation**, **refactoring**, and **catching errors**.

## Challenges

This subsection catalogs the difficulties.

|  Challenge  | Description | 
 | --- |  ---  |
|  **Idiomatic code**  | Must accept **common patterns**, not reject everything | 
 | **Large codebases** |  Can't require **rewriting everything** at once  |
|  **Untypeable constructs**  | `eval`, **dynamic metaprogramming** | 
 | **Complex heuristics** |  Programmers don't know what patterns are **blessed**  |

## Types vs tags

This subsection addresses a common source of confusion.

**Pitfall:** `typeof` (JavaScript) and `type()` (Python) return **tags**, not types!

```jsx
typeof ((x) => x)           // "function"
typeof ((x, y) => x + y)    // "function" - same tag!
```

Both are "function" even though they have **different types**: `(T -> T)` vs `(Number, Number -> Number)`.

**Difference:**

|  Aspect  | Types |  Tags  |
|  ---  | --- |  ---  |
|  **Number**  | Unbounded (infinitely many) |  Fixed, **finite** set  |
|  **Size**  | Can be arbitrarily complex |  Small, **constant**  |
|  **Check time**  | **Compile time** |  **Runtime**, O(1)  |

**Better name:** `tagof` not `typeof` - they report runtime tags, not static types.

# Nominal types

This section introduces **nominal typing**, the approach used by Java, C#, and many mainstream languages.

## What is nominal typing?

This subsection defines the concept through examples.

**Nominal:** From Latin "**nomen**" (name). Type identity based on **name**, not structure.

```java
class mt extends BT { public int size() { return 0; } }
class empty extends BT { public int size() { return 0; } }  // Identical structure!

static int m(mt o) { return o.size(); }
m(new empty());  // ERROR! Expects mt, not empty
```

**Even though `empty` is structurally identical to `mt`**, they are **different types** because they have **different names**.

## How nominal typing handles variants

This subsection shows how Java represents what would be algebraic datatype variants.

```java
abstract class BT { abstract public int size(); }

class mt extends BT {
    public int size() { return 0; }
}

class node extends BT {
    int v; BT l, r;
    public int size() { return 1 + l.size() + r.size(); }
}
```

**If-splitting via dynamic dispatch:**

- Two `size` methods, **one per class**.
- **Runtime picks** correct one based on actual object.
- In `node.size()`, `this.l` and `this.r` are **guaranteed to exist**.

**Connection to algebraic datatypes:**

- Algebraic datatypes: **fixed variants**, **extensible functions**.
- Java classes: **fixed behaviors** (methods), **extensible variants** (subclasses).
- Neither has inherent advantage - this is the **Expression Problem**.

# Structural types

This section introduces **structural typing**, the alternative to nominal typing.

## What is structural typing?

This subsection defines the concept and shows its flexibility.

**Structural:** Type identity based on **structure** (shape, services provided).

```
mt    : {size : (-> int)}
node  : {size : (-> int)}
empty : {size : (-> int)}  // Same type as mt!
```

**Usage:**

```
static int m(o : {size : (-> int)}) {
    return o.size();
}
m(new mt());     // OK
m(new empty());  // OK - same structure!
```

**Also called:** "**Duck typing**" (informally) - "if it quacks like a duck\ldots" The name comes from the idea that if an object has all the methods you need, you can use it regardless of its declared type.

# Subtyping

This section introduces **subtyping**, which allows substitution of "more specific" types for "more general" ones.

## What is subtyping?

This subsection defines the concept formally.

**Subtyping relation:** `X <: Y` means X can be **used wherever** Y is expected.

- Read `<:` like "**less than**" or "**contained in**".
- X is a **subtype** of Y.
- X can safely **substitute** for Y.
- Often called **substitutability** or **Liskov Substitution Principle**.

## Java's approach: nominal subtyping

This subsection shows how Java combines nominal types with subtyping.

```java
class A { String who = "A"; }
class B extends A { String who = "B"; }
class C extends A { String who = "C"; }
```

**Subclass = subtype** in Java. This is a **controversial choice** - not all OO languages do this, because inheritance and subtyping are conceptually different.

## Least upper bound (`lub`)

This subsection explains how Java computes types when branches have different types.

**Conditional with subtyping:**

```java
(true ? new B() : new C()).who  // Result type: A
```

**Rule:**

$$
\dfrac{\Gamma \vdash C : \text{Bool} \quad \Gamma \vdash T : V \quad \Gamma \vdash E : W}{\Gamma \vdash (\text{if} \; C \; T \; E) : X} \quad \text{where } X = \text{lub}(V, W)
$$

**`lub(B, C) = A`** - the "**lowest**" common **supertype**. A is above both B and C in the class hierarchy.

## Comparison of conditional approaches

This subsection compares all the approaches we've seen for typing conditionals.

| Approach | Rule | Flexibility | Result usability |
| --- | --- | --- | --- |
| **Same type** | Both branches must match | Rigid | **Most usable** |
| **Union types** | Creates `(U V W)` | Medium | Need **if-splitting** |
| **Subtyping** | Computes `lub(V, W)` | **Most flexible** | Could be `Object` (nearly useless) |

**Trade-off:** More flexibility in what branches can return \to **less precise** result type.

# Gradual typing

This section introduces **gradual typing**, which allows mixing typed and untyped code. This is essential for practical adoption of types in existing codebases.

## The migration problem

This subsection frames the practical challenge that motivates gradual typing.

**Scenario:** Large **untyped codebase**, want to add types **gradually**.

**Obstacles:**

1. Too much code to **convert at once**.
2. Some code may be **untypeable** (`eval`, metaprogramming).

**Solution:** **Gradual typing** - add types incrementally, one piece at a time.

## Micro vs macro gradual typing

This subsection presents two different approaches to gradual typing.

| Aspect | Micro | Macro |
| --- | --- | --- |
| **Granularity** | Any variable | Module boundary |
| **Mixing** | Types and untyped **freely intermingle** | **Two separate languages** |
| **Soundness** | Complex, **unclear guarantees** | **Clear per-language** |
| **Example** | Static Python | Typed Racket |

**Micro example:**

```python
def f(a, x, lo: int = 0, hi: Optional[int] = None):
    # lo and hi annotated, a and x not
```

**Macro approach:**

- **Typed language** and **untyped language** are "siblings".
- Values travel between via **contracts**.
- Each language is **internally consistent**.

## Typed Racket contracts

This subsection shows how macro gradual typing works in practice.

**In typed module:**

```racket
#lang typed/racket
(define (f [s : String]) : Number
  (+ 1 (or (string->number s) 0)))
(provide f)
```

**Imported into untyped:**

```racket
#lang racket
(require "typed.rkt")
(f 5)  ; Contract violation!
```

**What happens:**

```racket
; f is wrapped with contracts:
(define (wrapped-f s)
  (if (string? s)
      (let ([b (+ 1 (or (string->number s) 0))])
        (if (number? b)
            b
            (error 'contract "not a Number")))
      (error 'contract "not a String")))
```

**Benefits:**

- Type annotations are **enforced** even in **untyped code**.
- Errors are **early and informative**.
- **Blame tracking** identifies which module violated contract.

## Higher-order contracts

This subsection shows how contracts work for functions that take functions as arguments.

```racket
(define (h [i : (-> String Number)]) : Number
  (+ (i "5") 1))
```

**When called from untyped code with wrong function:**

```racket
(define (str-dbl s) (string-append s s))
(h str-dbl)  ; Contract violation when (i "5") returns!
```

**Key insight:** Contract checks happen at the **boundary** where values cross between languages. For higher-order functions, this means checking when the function is **called**, not when it's passed.

# Summary table

| Concept | Definition | Key point | Connection |
| --- | --- | --- | --- |
| **Static types** | Checked before execution | Guarantees without running | Foundation for all type systems |
| **Type calculator** | Returns Type, not Boolean | Enables checking operation compatibility | Strengthens **inductive hypothesis** |
| **Judgment** | Complete type derivation tree | Type error = **failed judgment** | Maps to recursive type checker |
| **Type environment (\Gamma)** | Maps variables to types | Enables **variable typing** | Parallels **value environment** |
| **Arrow types** | `(T -> U)` | Encodes **function contract** | Enables **application checking** |
| **Assume-guarantee** | Mutual obligations between rules | Lambda assumes; application guarantees | Pattern in **all type systems** |
| **Strong normalization** | All STLC programs terminate | Types affect **expressiveness** | Adding **recursion** breaks this |
| **rec construct** | Enables recursion | Both sides in **extended env** | Cannot **desugar** from lambda |
| **Safety** | Operations check validity | Prevents **misinterpretation** | **Tags** enable safety |
| **Tags** | Runtime type markers | Enable **safety checks** | Space-time cost |
| **Soundness** | Type prediction matches runtime | Enables **optimization** | Must be **formally proven** |
| **Type inference** | Automatic type determination | **Hindley-Milner** algorithm | Constraint generation + solving |
| **Algebraic datatype** | Named **sum of products** | **Tagged union** | **Pattern matching** baked in |
| **Pattern matching** | Deconstruct by variant | Variables **auto-typed** | Enables **safe access** |
| **Union types** | Combine existing types | **Untagged** | Need **if-splitting** to use |
| **If-splitting** | Narrow type via predicates | Also: **occurrence/flow typing** | **Eliminates unions** |
| **Nominal typing** | Identity by **name** | Even identical structures differ | **Java** approach |
| **Structural typing** | Identity by **structure** | "**Duck typing**" | More flexible |
| **Subtyping** | X <: Y = X substitutes for Y | **lub** in conditionals | Can lose precision |
| **Gradual typing** | Incremental typing | **Micro** vs **macro** | **Contracts** enforce at boundary |

# Key pitfalls summary

| Pitfall | Why it's wrong | Correct approach |
| --- | --- | --- |
| **Boolean type checker** | Can't distinguish compatible types | Return actual **Type** |
| Call antecedent "**numerator**" | Wrong terminology | **Antecedent/consequent** |
| Expecting **one branch** checked | Type checker is **conservative** | Both branches **always** checked |
| Using `Fun` for all functions | Can't check **argument compatibility** | Use **arrow types** `(T -> U)` |
| Thinking type checker = evaluator | Different **traversal strategies** | Types abstract, don't execute |
| **Unsafe accessors** on union | Static type **too coarse** | Use **pattern matching** or **if-splitting** |
| Conflating **types** and **tags** | Tags are **finite**, types aren't | `typeof` should be `tagof` |
| **Assuming soundness** | Must be **proven formally** | Violations = **security holes** |
| Expecting **precise** inference errors | No annotation = can't **blame location** | Report **all conflicting constraints** |
| **Subclass = subtype** always | Conceptually different | Consider **carefully** for each language |

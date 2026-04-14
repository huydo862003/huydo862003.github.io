---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Chapter 5. the untyped/pure lambda-calculus"
author: Benjamin C. Pierce
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - structural-abstract-syntax-concrete-surface-syntax
  - pure-untyped-lambda-calculus-call-by-value
  - derived-form
  - lambda-calculus
  - lambda-abstraction-lambda-calculus
  - abstract-syntax-tree-ast-labeled-tree
  - lexical-analysis-parsing
  - combinator
  - pure-untyped-lambda-calculus
  - application-function-call
  - beta-redex-reducible-expression
  - beta-reduction-beta-redex-reducible-expression
  - evaluation-strategy
  - call-by-need-call-by-name-call-by-value-normal-order-full
  - evaluation-strategy-strict-eager-evaluation-strategy-lazy
  - one-step-evaluation-relation-partial-function
  - pure-untyped-lambda-calculus-currying
  - church-boolean-pure-untyped-lambda-calculus
  - pure-untyped-lambda-calculus-pair-encoding
  - pure-untyped-lambda-calculus-church-numeral
  - church-boolean-church-numeral-pure-untyped-lambda-calculus
  - church-numeral
  - divergent-big-omega-combinator
  - curry-y-combinator-z-combinator
  - fixed-point-combinator
  - divergent-big-omega-combinator-curry-y-combinator
  - capture-avoiding-substitution-variable-capture
  - capture-avoiding-substitution
  - alpha-conversion-renaming-variable-capture-capture-avoiding
parent: part-i-untyped-systems
children: []
---

Review the definition and properties of the **untyped** or **pure lambda calculus**.

→ The underlying "**computational substrate**" for most of the **type systems**.

# Context & history

- Mid 1960, Peter Landin observed that a **complex programming language** can be understood by:
    - The formulation of the language as a **tiny core calculus** *capturing the language's essential mechanisms*.
    - Together with a collection of convenient **derived forms** whose behavior is understood by translating them into the core.
    
    [Landin, 1964, 1965, 1966; Tennent, 1981]
    
- The core language used by Landin was the **lambda-calculus**, a **formal system** invented in the 1920s by [Alonzo Church, 1936, 1941], in which all computation is
reduced to the basic operations of function definition and application.
- Following Landin's insight, as well as the pioneering work on Lisp [John McCarthy, 1959, 1981], the **lambda-calculus** has seen widespread use in many areas.
    - **The specification of programming language features**.
    - **Language design**.
    - **Language implementation**.
    - The study of **type systems**.
- The lambda calculus's importance arises from the fact that it can be viewed simultaneously as:
    - A **simple programming language** in which computations can be described.
    - A **mathematical object** about which rigorous statements can be proved.
- The **λ-calculus** is just one among many core calculi used to study and define programming languages.
    - The **π-calculus** [Milner, Parrow, Walker, 1991-1992] serves as a core language for modeling **message-passing concurrency**.
    - **Abadi and Cardelli's object calculus** (1996) captures the essential features of **object-oriented languages**.
    
    → Most of the ideas and techniques for the **λ-calculus** **transfer quite directly** to **the other calculi**.
    
- The **λ-calculus** can be **enriched in several ways**.
    - We can add **concrete syntax** for features like numbers, tuples, records, etc., whose behavior can already be encoded in the core language, but which are more convenient to work with in "built-in" form.
    - We can also add **more complex features** such as:
        - Mutable reference cells.
        - Nonlocal exception handling.
            
            These can, in principle, be simulated in the pure λ-calculus, but only via **heavy and indirect encodings**.
            
    - Such extensions gradually lead to **full-fledged programming languages**, for example:
        - **ML** [Gordon, Milner, Wadsworth, 1979; Milner, Tofte, Harper, 1990; Milner, Tofte, Harper, MacQueen, 1997; etc.]
        - **Haskell** [Hudak et al., 1992]
        - **Scheme** [Sussman and Steele, 1975; Kelsey, Clinger, Rees, 1998]
    - **Extending the core language** almost always *goes hand-in-hand* with **extending the type system**: richer language features typically require richer typing disciplines to describe and control their behavior.

# Basics

- **Procedural** (or **functional**) **abstraction** is a key feature of essentially all programming languages.
    
    $\lambda n. \text{expr}$ → a shorthand for "**the function that, for each $n$, yields $\text{expr}$**".
    
    Example: $\text{factorial} = \lambda n. \text{ if } n = 0 \text{ then }0 \text{ else } n * \text{factorial }(n-1)$
    
    → $\text{factorial}(0)$ means "**the function $\lambda n. \text{ if } n = 0 \text{ then }0 \text{ else } n * \text{factorial }(n-1)$ applied to $0$**".
    
- **Lambda-calculus** (or **λ-calculus**) consists of:
    - Function definition.
    - Function application.
    
    …in the purest possible form.
    
- In the lambda-calculus, **everything is a function**:
    - The arguments accepted by functions are themselves functions.
    - The result returned by a function is another function.
- Lambda-calculus comprises just 3 sorts of terms:
    - A variable $x$ by itself is a term.
    - The abstraction of a variable $x$ from a term $t_1$, written $\lambda x.t_1$, is a term.
    - The application of a term $t_1$ to another term $t_2$, written $t_1\, t_2$, is a term.

The syntax of lambda calculus

## Abstract and concrete syntax

- It's useful to distinguish **two levels of structure**:
    - **Concrete syntax (surface syntax)**: the actual strings of characters that programmers read and write.
    - **Abstract syntax**: a simpler, internal representation of programs as **labeled trees**, usually called **abstract syntax trees (ASTs)**.
- **Abstract syntax trees (ASTs)** make the structure of programs explicit:
    - They represent programs as trees instead of raw text.
    - This tree structure is ideal for:
        - **Formal language definitions** and **proofs** about languages.
        - The internal workings of **compilers** and **interpreters**, which need to manipulate program structure precisely.
- Concrete syntax → Abstract syntax usually happens in **two stages**:
    - **Lexical analysis (lexing)**
        - A **lexer** converts the raw character stream into a sequence of **tokens**: identifiers, keywords, constants, punctuation, etc.
        - It also:
            - Removes comments.
            - Handles whitespace and capitalization conventions.
            - Deals with formats for numeric and string literals.
    - **Parsing**
        - A **parser** takes the sequence of tokens and builds an **abstract syntax tree**.
        - During parsing, rules like **operator precedence** and **associativity** reduce the need for excessive parentheses in the source code.
        - For example:
            - The operator binds more tightly than `+`.
            - So the expression `1 + 2 * 3` is parsed as `1 + (2 * 3)` rather than `(1 + 2) * 3`.
- The main focus is on **abstract syntax**, *not* **concrete syntax**:
    - Grammars (like the grammar for λ-terms) should be read as descriptions of **legal tree structures**, not just valid strings of characters.
    - When we write terms in text-examples, definitions, theorems, proofs-we use a **linear concrete notation**, but we always implicitly mean the corresponding **abstract syntax tree**.
- To avoid writing too many parentheses when λ-terms are written in linear form, we adopt two standard conventions:
    - **Application is left-associative**
        - The expression `s t u` is read as `(s t) u`, not `s (t u)`.
    - **Abstraction bodies extend as far to the right as possible**
        - The expression `λx. λy. x y x` is read as:
            - `λx. (λy. ((x y) x))`
        - That is, the body of each λ-abstraction includes everything to its right unless parentheses say otherwise.

## Variables and metavariables

- Metavariables vs object-language variables
    - $t$, $s$, $u$ (with subscripts) are **metavariables for arbitrary terms**.
    - $x$, $y$, $z$ are often **metavariables for arbitrary variables** (i.e., they range over variable names).
- Name overloading & disambiguation
    - The same symbols $x$, $y$, etc. are also used as **actual variables in the object language** (inside terms).
    - The intended role-metavariable vs. object-language variable-is always clear from **context**.
- Example: In "The term $\lambda x.\, \lambda y.\, x\, y$ has the form $\lambda z.\, s$, where $z = x$ and $s = \lambda y.\, x\, y$":
    - $z$ and $s$ are **metavariables**.
    - $x$ and $y$ are **object-language variables**.

## Scope

- In $\lambda x.\, t$, $\lambda x$ is a **binder** and its **scope** is the body $t$.
- An occurrence of $x$ is **bound** if it appears inside the body $t$ of some enclosing abstraction $\lambda x.\, t$.
- An occurrence of x is **free** if it is not bound by any surrounding abstraction on x.
- Examples:
    - $x\, y$ → both $x$ and $y$ are **free**.
    - $\lambda y.\, x\, y$ → $y$ is **bound**, $x$ is **free**.
    - $\lambda x.\, x$ → $x$ is **bound**.
    - $\lambda z.\, \lambda x.\, \lambda y.\, x\, (y\,  z)$ → all occurrences of $x$, $y$, and $z$ are **bound**.
    - $(\lambda x.\, x)\,  x$ → the first $x$ (inside $\lambda x.\, x$) is **bound**, the second $x$ (the argument) is **free**.
- A term with no free variables is called **closed**.
- **Closed terms** are also called **combinators**.
- Example: the **identity combinator**.
    - $id = \lambda x.\, x$
    - It simply **returns its argument unchanged**.

## Operational semantics

- In its **pure form**, the **lambda-calculus** has:
    - **No built-in constants** or primitive operators.
    - No **numbers**, arithmetic, conditionals, records, loops, sequencing, or I/O.
    - The *only* way to compute is by **applying functions to arguments** (and both are just terms).
- A single **computation step**:
    - Rewrite a **function application** whose *left side* is an **abstraction**.
    - **Substitute** the **argument** for **the bound variable** in the **body**.
    
    $$
     (\lambda x.\ t_{12})\ t_2 \to [x \mapsto t_2]\ t_{12} 
    $$
    
    where $[x \mapsto t_2] t_1_2$  means "the term obtained by replacing all **free** occurrences of $x$ in $t_1_2$ with $t_2$."
    
- Examples:
    - $(\lambda x.\ x)\ y \to y$
    - $(\lambda x.\ x\ (\lambda x.\ x))\ (u\ r) \to u\ r\ (\lambda x.\ x)$
- Follow Church:
    - A term of the form **$(\lambda x.\ t_{12})\ t_2$** is called a **redex** (*reducible expression*).
    - The act of rewriting a redex using the rule above is called **beta-reduction** (**\beta-reduction**).
- **Evaluation strategy**: Which **redex (or redexes)** in a term may be reduced at the next **evaluation** step.
    - There can be **multiple evaluation strategies** for the **lambda calculus.**
    - Different strategies (e.g., normal order, call by value) choose **different redexes**, but **all are based on the same beta-reduction rule** above.

### Evaluation strategies

- Context:
    - $\text{id} = \lambda x.\ x$.
    - Consider this term: $t = \text{id}\ (\text{id}\ (\lambda z.\ \text{id}\ z))$.
        
        There are 3 redexes: The outer $\text{id}\ (...)$, the inner $\text{id}\  (\lambdaz.\ \text{id}\ z)$, and the $\text{id}\ z$ inside.
        
- There can be many reductions for the full beta-reduction strategy.
- **Full beta-reduction**
    - Any **redex** can be reduced **anywhere** in the term at any step.
        
        $(\lambda x.\ t_{12})\ t_2 \to [x \mapsto t_2]\ t_{12}$
        
    - One possible **full-reduction sequence** (**reducing innermost first**):
        
        $\text{id}\ (\text{id}\ (\lambda z.\ \text{id}\ z))$
        
        $\to\ \text{id}\ (\text{id}\ (\lambda z.\ z))$
        
        $\to\ \text{id}\ (\lambda z.\ z)$
        
        $\to\ \lambda z.\ z$
        
        $\not\to$
        
- Under the later strategies, the one-step evaluation relation is a **partial function**: each term has **at most one** next step.
- **Normal order**
    - Always reduce the **leftmost, outermost** redex first.
    - The normal-order reduction:
        
        $\text{id}\ (\text{id}\ (\lambda z.\ \text{id}\ z))$
        
        $\to\ \text{id}\ (\lambda z.\ \text{id}\ z)$
        
        $\to\ \lambda z.\ \text{id}\ z$
        
        $\to\ \lambda z.\ z$
        
        $\not \to$ 
        
- **Call by name**
    - Like normal order, but **no reduction inside abstractions**.
    - Same first steps as normal order, but stop once the result is a \lambda-abstraction:
        
        $\text{id}\ (\text{id}\ (\lambda z.\ \text{id}\ z))$
        
        $\to\ \text{id}\ (\lambda z.\ \text{id}\ z)$
        
        $\to\ \lambda z.\ \text{id}\ z$
        
        $\not \to$
        
    - Here, $\lambdaz.\, \text{id}\,  z$ is treated as a **normal form** (no further reduction inside the body).
    - Variants of **call by name** appear in languages like **Algol 60** and in optimized form (**call by need**), **Haskell**.
- **Call by need**
    - An optimized **non-strict** strategy (used in Haskell).
    - Similar to call by name, but **shares** the result of evaluating an argument:
        - First use of the argument evaluates it.
        - All other uses reuse that value (no re-evaluation).
    - Conceptually works on **graphs** (shared structure), not just trees.
- **Call by value**
    - Only **outermost** redexes are reduced, and only when the argument is already a **value**.
    - The example reduces as:
        
        $\text{id}\ (\text{id}\ (\lambda z.\ \text{id}\ z))$
        
        $\to\ \text{id}\ (\lambda z.\ \text{id}\ z)$
        
        $\to\ \lambda z.\ \text{id}\ z$
        
        $\not \to$
        
    - This is a **strict** strategy: function arguments are **always evaluated**, whether or not they are actually used.
    - In contrast, **non-strict** (or **lazy**) strategies like call by name/need only evaluate arguments that are actually used.
- The choice of evaluation strategy has **little effect** on the **core issues of type system design**. Most typing concepts and techniques apply similarly across strategies.
|   **Strategy**  |  **Which redex is reduced?** |   **Reduce inside \lambda-bodies?**  |  **When are arguments evaluated?** |   **Strict?**  |  **Pros** |   **Cons**  |
|   ---  |  --- |   ---  |  --- |   ---  |  --- |   ---  |
|   **Full \beta-reduction**  |  Any redex, anywhere in the term |   Yes  |  No fixed policy; any redex may be chosen |   Not really an execution strategy  |  Very **flexible**; useful for **theoretical reasoning** about equivalence and normalization. |   **Non-deterministic**; not a realistic implementation strategy; no notion of "order of evaluation."  |
|   **Normal order**  |  Leftmost, outermost redex |   Yes  |  Arguments reduced only when needed (when their redex is outermost) |   Non-strict  |  **Normalizing**: if a normal form exists, this strategy **will find it**; good for reasoning. |   Can be **inefficient** (may re-evaluate the same argument many times); less practical in naive form.  |
|   **Call by name**  |  Leftmost, outermost redex, but not inside \lambda-abstractions |   No  |  Arguments are substituted but not evaluated inside \lambda-bodies |   Non-strict  |  Captures **lazy behavior** at a simple semantic level; good as a **theoretical model**. |   Still **re-evaluates** arguments when used multiple times; not efficient enough by itself.  |
|   **Call by need**  |  Like call by name, but with sharing of evaluated arguments |   No  |  Argument evaluated at most once, then its value is shared |   Non-strict (lazy)  |  **Avoids repeated work** via sharing; basis for **lazy functional languages** (e.g. Haskell). |   Requires **graph-based** implementation with sharing; runtime model more **complex** than CBV.  |
|   **Call by value**  |  Outermost redex whose argument is already a value |   Typically no  |  Arguments evaluated **before** function body runs |   Strict  |  Simple, **efficient**, and matches most **real-world languages** (ML, OCaml, Java, etc.). |   Cannot evaluate terms that rely on **non-termination avoidance** (e.g. some lazy constructions); less flexible than lazy strategies.  |
# Programming in the lambda calculus

- The **lambda-calculus** has an extremely **small core** (just variables, abstraction, application) but is **surprisingly powerful**.
- **Many language features** (multi-argument functions, booleans, pairs, numbers, lists, etc.) **can be encoded** *inside* the **pure calculus**.
- Motivations:
    - These encodings are **"warm-up exercises"** to understand the system.
    - Not endorsements of \lambda-calculus as a practical programming language.

## Multiple arguments (currying)

- The pure lambda-calculus has **no built-in multi-argument functions**.
- Instead of writing something like $f(x, y)$, we use **higher-order functions** and **currying**:
    - Desired informal form:  $f(x, y) = s[x \mapsto v, y \mapsto w]$
    - Curried encoding:
        
         $f = \lambda x.\ \lambda y.\ s$ 
        
        - First apply $f$  to $v$: $f\ v = \lambda y.\ [x \mapsto v] s$.
        - Then apply to $w$:  $f\ v\ w = (\lambda y.\ [x \mapsto v] s)\ w \to [y \mapsto w][x \mapsto v] s$ .
- This transformation of **multi-argument functions** to **chains of single-argument functions** is called **currying** (after Haskell Curry).

## Church booleans

- Encode booleans as functions:
    - $\text{tru} = \lambda t.\ \lambda f.\ t$
    - $\text{fls} = \lambda t.\ \lambda f.\ f$
- A generic "if" (conditional) combinator:  $\text{test} = \lambda l.\ \lambda m.\ \lambda n.\ l\ m\ n$
    - $\text{test}\ \text{tru}\ v\ w \to v$
    - $\text{test}\ \text{fls}\ v\ w \to w$
- Intuition: the boolean **itself** acts as the conditional:
    - $\text{tru}\ v\ w$ chooses the **first** argument.
    - $\text{fls}\ v\ w$ chooses the **second** argument.

### Boolean operators

- $\text{and} = \lambda b.\ \lambda c.\ b\ c\ \text{fls}$
    - If $b = \text{tru}$, result is $c$.
    - If $b = \text{fls}$, result is $\text{fls}$.
    - So $\text{and}\ b\ c$ is $\text{tru}$ iff both $b$ and $c$ are $\text{tru}$.

**Exercise 5.2.1** Define logical $\text{or}$ and $\text{not}$ functions.

<details>

<summary>Solution</summary>



- $\text{or} = \lambda b.\ \lambda c.\ b\ \text{tru}\ c$
- $\text{not} = \lambda b.\ \lambda t.\ \lambda f.\ b\ f\ t$



</details>

## Pairs

- Encode a **pair** of values using **booleans**:
    
     $\text{pair} = \lambda f.\ \lambda s.\ \lambda b.\ b\ f\ s$ 
    
     $\text{fst} = \lambda p.\ p\ \text{tru}$ 
    
     $\text{snd} = \lambda p.\ p\ \text{fls}$ 
    
- Intuition:
    - $\text{pair}\ v\ w$ is a function expecting a boolean $b$ and returning $b\ v\ w$.
    - If  $b = \text{tru}$, we get $v$ if $b = \text{fls}$, we get $w$.
    - So:
        - $\text{fst}\ (\text{pair}\ v\ w) \to v$
        - $\text{snd}\ (\text{pair}\ v\ w) \to w$

## Church numerals

- Encode **natural numbers** as "iterate a function $n$ times":
    
     $c_0 = \lambda s.\ \lambda z.\ z$ 
    
     $c_1 = \lambda s.\ \lambda z.\ s\ z$ 
    
     $c_2 = \lambda s.\ \lambda z.\ s\ (s\ z)$ 
    
     $c_3 = \lambda s.\ \lambda z.\ s\ (s\ (s\ z))$ 
    
     $\dots$ 
    
- In general, $c_n$ represents "apply $s$ to $z$, $n$ times".
- Note: $c_0$ and $\text{fls}$ are actually the **same term**, just used with different intended meanings. This is interesting, as $0$ is falsy in most programming languages.
- Looks like **fixed point approximation**?

- **Successor** ($n \mapsto n + 1$):  $\text{scc} = \lambda n.\ \lambda s.\ \lambda z.\ s\ (n\ s\ z)$
- **Addition** ($m + n$):
    
     $\text{plus} = \lambda m.\ \lambda n.\ \lambda s.\ \lambda z.\ m\ s\ (n\ s\ z)$ 
    
    - First use $n\ s\ z$ to apply $s$ **n times**.
    - Then apply $s$  **m more times** via $m$.
- **Multiplication** ($m \times n$) using plus:
    
     $\text{times} = \lambda m.\ \lambda n.\ m\ (\text{plus}\ n)\ c_0$ 
    
    - $\text{plus}\ n$ is a function "add $n$".
    - $m\ (\text{plus}\ n)\ c_0$ means "start at $0$, add $n$, $m$ times" \to  $m \times n$.

**Exercise 5.2.2** Find another way to define the successor function on Church numerals.

<details>

<summary>Solution</summary>



$\text{scc} = \lambda n.\ \lambda s.\ n\ s\ (c_1\ s\ z)$  




**Exercise 5.2.3** Is it possible to define multiplication on Church numerals without using $\text{plus}$?

</details>

<details>

<summary>Solution</summary>



$\text{times} = \lambda m.\ \lambda n.\ \lambda s.\ \lambda z.\ m\ (n\ s)\ z$ 




**Exercise 5.2.4** Define a term for raising one number to the power of another.

</details>

<details>

<summary>Solution</summary>



$\text{pow} = \lambda m.\ \lambda n.\ \lambda s.\ \lambda z.\ m\ (\text{times}\ n)\ c_0$




- **Zero test**:  $\text{iszro} = \lambda m.\ m\ (\lambda x.\ \text{fls})\ \text{tru}$
- $\text{iszro}\ c_0 \to \text{tru}$ (no steps applied).
- $\text{iszro}\ c_k \to \text{fls}$ for $k \ge 1$ (at least one overwrite).
- **Predecessor**:
- Idea: track pairs $(c_i, c_{i+1})$.
- Helper definitions:
- $\text{zz} = \text{pair}\ c_0\ c_0$
- $\text{ss} = \lambda p.\ \text{pair}\ (\text{snd}\ p)\ (\text{succ}\ (\text{snd}\ p))$
</details>

    - Definition:  $\text{prd} = \lambda m.\ \text{fst}\ (m\ \text{ss}\ \text{zz})$
        - Starting from $(c_0, c_0)$, each application of $\text{ss}$ transforms
            
             $(c_i, c_j) \mapsto (c_j,\ c_{j+1})$ 
            
        - After $m$ steps, we get $(c_{m-1}, c_m)$ or $(c_0, c_0)$ when $m = 0$.
        - Taking **$\text{fst}$** gives the **predecessor**.

**Exercise 5.2.5** Use $\text{prd}$ to define a subtraction function.

<details>

<summary>Solution</summary>



$\text{sub} = \lambda m.\ \lambda n.\ n\ \text{prd}\ m$




**Exercise 5.2.6** Approximately how many steps of evaluation (as a function of $n$) are required to calculate $\text{prd}\ c_n$?

</details>

<details>

<summary>Solution</summary>





**Exercise 5.2.7** Write a function $\text{equal}$ that tests two numbers for equality and returns a Church boolean.

</details>

<details>

<summary>Solution</summary>



$\text{equal} = \lambda m.\ \lambda n.\ \text{and}\ (\text{iszro}\ (\text{sub}\ m\ n))\ (\text{iszro}\ (\text{sub}\ n\ m))$ 
</details>

## Other datatypes

Many other structures (lists, trees, variants, arrays) can be encoded similarly.

**Exercise 5.2.8** A list can be represented in the lambda-calculus by its $\text{fold}$ function. (OCaml's name for this function is $\text{fold\_left}$; it is also sometimes called $\text{reduce}$.) For example, the list $[x,y,z]$ becomes a function that takes two arguments $c$ and $n$ and returns$c\ x\ (c\ y\ (c\ z\ n)))$. What would the representation of $\text{nil}$ be? Write a function $\text{cons}$ that takes an element $h$ and a list (that is, a $\text{fold}$ function) $t$ and returns a similar representation of the list formed by prepending $h$ to $t$. Write $\text{isnil}$ and $\text{head}$ functions, each taking a list parameter. Finally, write a $\text{tail}$ function for this representation of lists (this is quite a bit harder and requires a trick analogous to the one used to define $\text{prd}$ for numbers).

<details>

<summary>Solution</summary>



- $\text{nil} = \lambda c.\ \lambda n.\ n$
- $\text{cons} = \lambda h.\ \lambda t.\ \lambda c.\ \lambda n.\ (c\ h\ (t\ c\ n))$
- $\text{isnil} = \lambda t.\ t\ (\lambda e.\ \lambda n.\ \text{fls}) \   \text{tru}$
- $\text{head} = \lambda t.\ t\ \text{tru}\ \text{nil}$
- $\text{tail} = \lambda t.\ \text{fst}\ (t\ tt\ nn)$
- $nn = \text{pair}\ \text{nil}\ \text{nil}$
- $tt = \lambda e.\ \lambda p.\ \text{pair}\ (\text{snd}\ p)\ (\text{cons}\ e\ (\text{snd}\ p))$



</details>

## Observations

The definitions for the Church numerals and lists encoding get me thinking about the technique:

- Think of a base value in the domain: $0$ for numbers and $\text{nil}$ for lists.
- Think of a base operation in the domain that can create any values from the base value: addition for numbers and cons-ing for lists.
- Then:
    - For numerals:
        - The 0-th value: $\lambda c.\ \lambda z.\ z$.
        - The $n$-th value: $\lambda c.\ \lambda z.\ c\ (v_{n - 1 }\ c\  z)$.
    - For lists:
        - The 0-th value: $\lambda c.\ \lambda n.\ n$.
        - The 1-st value: $\lambda c.\ \lambda n.\ c\ e_1\ (v_0\ c\ n)$ .
        - The $n$-th value: $\lambda c.\ \lambda n.\  c\ e_n\ (v_{n-1}\ c\ n)$.

## Enriching the calculus

- In the pure **lambda-calculus** we can already encode **booleans**, **numbers**, and their **operations**, so in principle we can write *all* our programs there.
- In practice, it is often more convenient to work in an **enriched language** that has **primitive booleans and numbers** as well.
- **Pure lambda-calculus** is denoted by $\lambda$.
    
    No built-in booleans or numbers; everything is encoded.
    
- **Pure lambda-calculus enriched with booleans and naturals** is denoted by $\lambda\textbf{NB}$.
    
    Has primitive $\text{true}$, $\text{false}$, numeric literals, $\text{succ}$, $\text{pred}$, $\text{iszero}$, etc. (as in the earlier arithmetic language in Chapter 3. Untyped arithmetic expressions).
    
- In $\lambda\textbf{NB}$, there are effectively **two versions** of booleans and numbers:
    - **Real (primitive)** values
    - **Encoded (Church)** values
    
    Conversions:
    
    - **Church boolean \to primitive boolean**: $\text{realbool} = \lambda b.\ b\ \text{true}\ \text{false}$.
    - **Primitive boolean \to Church boolean**: $\text{churchbool} = \lambda b.\ \text{if}\ b\ \text{then}\ \text{tru}\ \text{else}\ \text{fls}$.

### Why primitive values help: evaluation order & call by value

- We use **call by value** (CBV):
    - Do not reduce under lambdas.
    - Only reduce a redex when its argument is already a **value**.
- **Example: successor of a Church numeral**
    - We expect: $\text{scc}\ c_1 \to c_2$
    - But in CBV we actually get a \lambda-term that is **extensionally equal** to $c_2$, but not syntactically the same; some computation is "stuck under a \lambda" and cannot be reduced further under CBV.
    - So $\text{scc}\ c_1$ is **behaviorally equivalent** to $c_2$ (they act the same when given $s$ and $z$), but not literally the same normal form.
- **Example: multiplication**
    - $\text{times}\ c_2\ c_2$ does **not** reduce to $c_4$ under CBV; it reduces to a large lambda-term with a lot of latent computation.
    - We can still check behavior by:
        - Comparing at the Church level:
            
            $\text{equal}\ c_4\ (\text{times}\ c_2\ c_2) \;\to\; \text{tru}$
            
        - Or more conveniently, converting to a primitive number:
            
            $\text{realnat}\ (\text{times}\ c_2\ c_2) \;\to\; 4$
            
    - Applying $\text{realnat}$ "finishes" the computation, because it **supplies the missing arguments** ($\text{succ}$ and $0$) and forces all remaining \beta-reductions.

Therefore:

- **Encodings** show that pure $\lambda$ is *expressive enough*.
- **Primitives + conversions** in $\lambda\textbf{NB}$ make examples and reasoning under **call-by-value** much easier to see and check.

## Recursion

- Some terms **never** reach a normal form; they are said to **diverge**.
- The classic **divergent/big omega combinator**:
    
    $$
    \Omega = (\lambda x.\ x\ x)\ (\lambda x.\ x\ x)
    $$
    
    - This term has exactly one **redex**; reducing it just gives back the **same term** $\omega$ again, so evaluation **loops forever**.
    - Any term with no normal form (like $\Omega$) is said to **diverge**.

- The **omega combinator** has a **useful generalization** called the **fixed-point combinator**.
    - The call-by-name version is called the **Y-combinator**.
    - The call-by-value version is called the **Z-combinator**.
- The **fixed-point combinator** $\text{fix}$ is used to specify **recursive definitions** in the **untyped \lambda-calculus**:
    
    $$
    \text{fix} = \lambda f.\ (\lambda x.\ f\ (\lambda y.\ x\ x\ y))\ (\lambda x.\ f\ (\lambda y.\ x\ x\ y))
    $$
    
    - $\text{fix}\ f$ gives you a term $h$ such that, operationally,
        
        $$
        \text{fix}\ f \approx\ f\ (\text{fix}\ f)
        $$
        
        so $f$ receives **a copy of its own result** as an argument.
        
    - How to derive the **call-by-value fixed-point combinator**: [Friedman and Felleisen, 1996, Chapter 9].

- There is also a simpler **call-by-name** **fixed-point combinator**:
    
    $$
    Y = \lambda f.\ (\lambda x.\ f\ (x\ x))\ (\lambda x.\ f\ (x\ x))
    $$
    
    but:
    
    - $Y$ **diverges under call-by-value**.
    - This is because CBV tries to evaluate $x\ x$ too eagerly.
    
    \to It is not usable as-is in the CBV setting.
    

- Using $\text{fix}$ to define recursive functions
    
    We want recursive definitions of the form:
    
    - **Informal recursive style**:
        
        $$
        h = \langle \text{body containing } h \rangle
        $$
        
    - To encode this in \lambda-calculus:
        1. First define a **non-recursive generator**:
            
            $$
            g = \lambda f.\ \langle \text{body containing } f \rangle
            $$
            
        2. Then define the recursive function as:
            
            $$
            h = \text{fix}\ g
            $$
            
    - Operational idea:
        - $\text{fix}\ g$ expands to something like $g\ (\text{fix}\ g)$.
        - Everywhere $f$ appears in the body of $g$, it is effectively unrolled with another copy of the recursive function.
        
        \to Each recursive call **"unrolls"** one more copy of the body.
        
- Example: $\text{factorial}$ with Church numerals
    
    $$
    g = \lambda \text{fct}.\ \lambda n.\ \text{if } \text{realeq}\ n\ c_0\ \text{ then } c_1\ \text{ else } \text{times}\ n\ (\text{fct}\ (\text{prd}\ n))
    \\
    \text{factorial} = \text{fix}\ g
    $$
    
    - The $\text{fix}$ machinery ensures that each time $\text{fct}$ is applied.
        
        \to $\text{fct}$ effectively behaves like **factorial itself**.
        
        \to The definition is **unrolled** one step at a time.
        
    - Conceptually, $\text{fct}$ is a **self-replicator**:
        
        Applying $\text{fct}\ n$ feeds $\text{fct}$ and $n$ back into $g$.
        
        \to Producing another expanded copy of the recursive body, with new $\text{fct}$s ready to continue the process.
        

**Exercise 5.2.9** Why did we use a primitive $\text{if}$ in the definition of $g$, instead of the Church-boolean $\text{test}$ function on Church booleans? Show how to define the $\text{factorial}$ function in terms of $\text{test}$ rather than $\text{if}$.

<details>

<summary>Solution</summary>



- This is because $\text{if}$ doesn't need to evaluate both of its branches before evaluating itself, while $\text{test}$ needs to evaluate both of its branches first.
- In other words, $\text{if}$ is lazy and $\text{test}$ is eager.
- If we use $\text{test}$ in the same way as $\text{if}$ in the above example, it would yield divergent terms on every application.
- How to define $\text{factorial}$ in terms of $\text{test}$: **Simulate call-by-name** using **thunks**.

$$
\text{factorial}\ n
= \lambda \text{fct}.\  \lambda n.\ (\text{test}\ (\text{equal}\ n\ 0)\ (\lambda \_.\ c_1)\ (\lambda \_.\ (\text{times}\ n\ (\text{fct}\ (\text{sub}\ n\ 1)))))\ \text{tru}
$$




**Exercise 5.2.10** Define a function $\text{churchnat}$ that converts a primitive natural number into the corresponding Church numeral.

</details>

<details>

<summary>Solution</summary>



$\text{churchnat} = \text{fix}\ \lambda\text{g}.\ \lambda n.\ \text{if } n = 0 \text{ then } c_0 \text{ else } \text{succ}\ (g\ (n - 1))$




**Exercise 5.2.11** Use $\text{fix}$ and the encoding of lists from Exercise 5.2.8 to write a function that sums lists of Church numerals.

</details>

<details>

<summary>Solution</summary>



$\text{sum} = \text{fix}\ \lambda g.\ \lambda l.\ \text{if } \text{isnil}\ l \text{ then }0\text{ else } \text{sum}\ (\text{head}\ l)\ (g\ (\text{tail}\ l))$ 
</details>

## Representation

- What does it mean that **Church numerals "represent" ordinary numbers**?
- Ordinary naturals (as in $\lambda\textbf{NB}$):
    - A constant: $0$.
    - Operations:
        - **$\text{succ}$: numbers \to numbers.
        - $\text{pred}$: numbers \to numbers.
        - $\text{iszero}$**: numbers \to booleans.
    - Their behavior is fixed by evaluation rules (e.g. $\text{succ}\ 2 = 3$, $\text{iszero}\ 0 = \text{true}$).
- **Church encoding idea:** represent all of these as **lambda-terms**.
    - **Zero:** $c_0 = \lambda s.\ \lambda z.\ z$
        
        Other **behaviorally equivalent** (non-canonical) terms (e.g. $\lambdas.\ \lambdaz.\ (\lambdax.\ x)\ z$) also count as representations of 0.
        
    - **Successor/predecessor:**
        - $\text{scc}$ represents **$\text{succ}$**:
            
            If $t$ represents $n$, then $\text{scc}\ t$ evaluates to a representation of $n + 1$.
            
        - $\text{prd}$ represents **$\text{pred}$**:
            
            If $t$ represents $n$, then $\text{prd}\ t$ evaluates to a representation of $\max(n-1, 0)$.
            
    - **Zero test:** $\text{iszro}$ represents **$\text{iszero}$**:
        - If $t$ represents 0, $\text{iszro}\ t$ evaluates to $\text{true}$.
        - If $t$ represents any $n \neq 0$, $\text{iszro}\ t$ evaluates to $\text{false}$.
- Representation correctness (observational view):
    - Take any program that:
        - Uses **primitive numbers** and operations ($0$, $\text{succ}$, $\text{pred}$, $\text{iszero}$, \ldots)
        - Produces a **boolean** result.
    - Replace all numbers and arithmetic operations with their **Church encodings** ($c_0$, $\text{scc}$, $\text{prd}$, $\text{iszro}$, \ldots).
    - After evaluation, the **final boolean result is the same**.
    - Therefore, **no observable difference**: Church numerals and primitive naturals behave the same from the **program's point of view**.

# Formalities

## Syntax

- The usual \lambda-calculus grammar (e.g. $t ::= x\ \vert  \ \lambdax.t\  \vert \ t\ t$) is shorthand for an **inductively defined set of abstract syntax trees**.
- Terms:
    - Fix a countable set of **variable names** **$V$.
    - The set of terms $T$** is the **smallest** set such that:
        1. $x \in T \ \text{for every } x \in V$.
        2. $\text{if } t_1 \in T \text{ and } x \in V,\text{ then } \lambda x.\ t_1 \in T$.
        3. $\text{if } t_1 \in T \text{ and } t_2 \in T,\text{ then } t_1\ t_2 \in T$.
- **Free variables** ($\text{FV}$)
    - **$\text{FV}(t)$** = set of variables that occur **free** in term **$t$**.
    - Rules:
        1. $\text{FV}(x) = {x}$.
        2. $\text{FV}(\lambda x.\ t_1) = \text{FV}(t_1) \setminus {x}$.
        3. $\text{FV}(t_1\ t_2) = \text{FV}(t_1) \cup \text{FV}(t_2)$.

**Exercise 5.3.3** Give a careful proof that $\vert  \text{FV}(t) \vert  \leq \text{size}(t)$ for every term $t$.

<details>

<summary>Solution</summary>





</details>

## Substitution

- Throughout, two definitions of substitution are used:
    - The compact and intuitive definition shown before: $[x \to s]$, optimized for **examples** and in **mathematical definitions** and **proofs**.
    - Another developed in Chapter 6, is **notationally heavier**, depending on an **alternative "de Bruijn presentation" of terms** in which **named variables** are replaced by **numeric indices**, but is more convenient for the concrete ML implementations.
- **Goal:** define **substitution** $[x \mapsto s] t$ in the \lambda-calculus **correctly** (capture-avoiding).

### **Naive substitution (wrong #1)**

- Defined structurally on term $t$:
    - $[x \mapsto s] x = s$.
    - $[x \mapsto s] y = y \quad \text{if } x \ne y$
    - $[x \mapsto s] (\lambda y.\ t_1) = \lambda y.\ [x \mapsto s]\ t_1$
    - $[x \mapsto s] (t_1\ t_2) = ([x \mapsto s]\ t_1)\ ([x \mapsto s]\ t_2)$
- Problem: does **not distinguish free vs bound** occurrences of $x$.
    
    Example: $[x \mapsto y](\lambda x.\ x) = \lambda x.\ y$
    
    \to This conflicts with the basic intuition about functional abstractions that **the
    names of bound variables do not matter**: The **identity function** is exactly the same whether we write it $\lambdax.\ x$ or $\lambday.\ y$ or $\lambda\text{franz}.\ \text{franz}$. If these do not behave exactly the same under substitution, then they will not behave the same under reduction either, which seems wrong.
    
- Mistake: No distinction between **free occurrences of a variable** (which should get replaced during substitution) and **bound ones**, which should not.

### **Improved substitution (wrong #2)** - stop at binder with the same name

- Modify abstraction case to **not substitute under a binder with the same name**:
    - $[x \mapsto s] x = s$
    - $[x \mapsto s] y = y \quad \text{if } y \ne x$
    - 
$$
[x \mapsto s] (\lambda y.\ t_1) = \begin{cases} \lambda y.\ t_1 & \text{if } y = x \\ \lambda y.\ [x \mapsto s]\ t_1 & \text{if } y \ne x \end{cases}
$$

    - $[x \mapsto s] (t_1\ t_2) = ([x \mapsto s]\ t_1)\ ([x \mapsto s]\ t_2)$
- Fixes earlier issue, but introduces **variable capture**:
    
    Example: $[x \mapsto z](\lambda z.\ x) = \lambda z.\ z$
    

### **Variable capture & capture-avoiding substitution**

- **Variable capture:** a **free variable** in $s$ becomes **bound** after substitution into $t$.
- To avoid this, in the abstraction case we must ensure the bound variable $y$:
    - is **not** $x$, and
    - does **not occur free** in $s$.
- **Capture-avoiding substitution:**
    - $[x \mapsto s] x = s$
    - $[x \mapsto s] y = y \quad \text{if } y \ne x$
    - 
$$
[x \mapsto s] (\lambda y.\ t_1) = \begin{cases} \lambda y.\ t_1 & \text{if } y = x \\ \lambda y.\ [x \mapsto s]\ t_1 & \text{if } y \ne x \text{ and } y \notin FV(s) \end{cases}
$$

    - $[x \mapsto s] (t_1\ t_2) = ([x \mapsto s]\ t_1)\ ([x \mapsto s]\ t_2)$
- The above definition is **partial**: if $y \neq x$ but $y \in \text{FV}(s)$, no clause applies.
    
    \to Work with terms "up to renaming bound variables".
    

### **Alpha-conversion**

- **\alpha-conversion:** Consistent renaming of a bound variable - $\lambday.\ x\ y \equiv \lambdaw.\ x\ w$.
- **Convention:** Terms that differ only by renaming bound variables are **interchangeable** - We work **"up to \alpha-conversion"**.
- If substitution would be undefined because $y \in \text{FV}(s)$, we **rename** the bound variable first.
    
    Example:
    
    $[x \mapsto y\ z](\lambda y.\ x\ y)$
    
    - First rename: $\lambday.\ x\ y$ \to $\lambdaw.\ x\ w$
    - Then: $[x \mapsto y\ z](\lambda w.\ x\ w) = \lambda w.\ (y\ z\ w)$

### **Final capture-avoiding substitution definition**

- Using the \alpha-conversion convention, we assume the binder $y$ is always chosen **fresh** (\neq $x$ and not free in $s$), so we can drop the special case:
    - $[x \mapsto s] x = s$
    - $[x \mapsto s] y = y \quad \text{if } y \ne x$
    - $[x \mapsto s] (\lambda y.\ t_1) = \lambda y.\ [x \mapsto s]\ t_1 \quad \text{if } y \ne x \text{ and } y \notin \text{FV}(s)$
    - $[x \mapsto s] (t_1\ t_2) = ([x \mapsto s]\ t_1)\ ([x \mapsto s]\ t_2)$
- This is the **standard capture-avoiding substitution** used in \lambda-calculus proofs and definitions.

## Operational semantics

The untyped lambda calculus \lambda

- **Values** are exactly **lambda-abstractions**:
    - $v ::= \lambda x.\ t$
    - Evaluation **stops** when it reaches a $\lambda$; arbitrary $\lambda$-terms can be values.
- **Small-step rules** (call-by-value application)
    1. `E-AppAbs` - computation rule
    2. `E-App1` ****(reduce the function part first) - congruence rule
    3. `E-App2` (then reduce the argument) - congruence rule
- How metavariables enforce evaluation order
    - $v_2$ in `E-AppAbs`: must be a **value**, so \beta-reduction only fires when the **argument is fully evaluated**.
    - $t_1$ in `E-App1`: any term; we reduce the **function position first** while it can step.
    - $v$ in `E-App2`: the left side must already be a **value**, so we only start reducing the argument **after** the function is done.
    - Combined, these rules enforce **call-by-value, left-to-right**:
        1. Reduce $t_1$ to a value (`E-App1`).
        2. Reduce $t_2$ to a value (`E-App2`).
        3. Apply \beta (`E-AppAbs`).
- Special property of the pure \lambda-calculus
    - Since **only \lambda-abstractions are values**, once $t_1$ has been reduced to a value (by `E-App1`), it **must** be a $\lambdax.\ t$.
    - This breaks once we enrich the language (e.g. add primitive booleans, numbers), where **values** include more forms than just \lambda-abstractions.

**Exercise 5.3.6** Adapt these rules to describe the other three strategies for evaluation-full beta-reduction, normal-order, and lazy evaluation.

<details>

<summary>Solution</summary>



- Full beta-reduction
1. $\displaystyle \frac{t_1 \to t_1' }{t_1\ t_2 \to t_1'\ t_2}$
2.  $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'}$ 
3. $\displaystyle \frac{t \to t'}{\lambda x.\ t \to \lambda x.\ t'}$ 
4. $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$
- Normal-order
1. $(\lambda x.\ t_1)\ t_2 \to [x \mapsto t_2]\, t_1$
2. $\displaystyle \frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \quad (t_1 \text{ is not a } \lambda)$
3. $\displaystyle \frac{t_2 \to t_2'}{t_1\ t_2 \to t_1\ t_2'} \quad (t_1 \text{ in normal form})$
4. $\displaystyle \frac{t \to t'}{\lambda x.\ t \to \lambda x.\ t'}$
- Call-by-name
1. $\displaystyle$ $\displaystyle \frac{t_1 \to t_1' }{t_1\ t_2 \to t_1'\ t_2}$
2. $(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1$



**Exercise 5.3.7** Exercise 3.5.16 gave an alternative presentation of the operational semantics of booleans and arithmetic expressions in which stuck terms are defined to evaluate to a special constant wrong. Extend this semantics to $\lambda\textbf{NB}$.

</details>

<details>

<summary>Solution</summary>





**Exercise 5.3.8** Exercise 4.2.2 introduced a "big-step" style of evaluation for arithmetic expressions, where the basic evaluation relation is "term $t$ evaluates to final result $v$." Show how to formulate the evaluation rules for lambda-terms in the big-step style.

</details>

<details>

<summary>Solution</summary>



1. $\displaystyle \frac{t_1 \Downarrow \lambda x.\ t_1' \quad t_2 \Downarrow v_2 \quad [x \to v_2]t_1' \Downarrow v}{t_1\ t_2 \Downarrow v}$
2. $\displaystyle \frac{[x\to t_2]t_1  \Downarrow v}{ (\lambda x.\ t_1)\ t_2 \Downarrow v}$


</details>

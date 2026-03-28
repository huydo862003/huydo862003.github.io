---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 1. Abstract syntax
author: Robert Harper
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts:
  - operator-arity
  - sort
  - variable
  - variable-abstract-syntax-tree-ast
  - operator-abstract-syntax-tree-ast
  - fresh-variable-abstract-syntax-tree-ast
  - substitution-subject-substitution-target
  - capture-avoiding-substitution
  - scope-binding
  - valence-actual-parameter-argument
  - congruence
  - alpha-equivalence
  - abstract-binding-tree-abt-valence-abstractor
  - abstract-binding-graph
  - fresh-renaming
parent: part-i-judgments-and-rules
children: []
---

- Programming languages describe **computations** for **humans and machines**.
- Syntax explains how phrases form programs, but "syntax" actually has layers:
    - **Concrete (surface) syntax**: how code is written/displayed as character strings (ASCII/Unicode).
        
        → Ignored.
        
    - **Abstract (structural) syntax**: the program's tree structure (**ASTs**) showing how phrases are built from operators and subphrases.
    - **Binding structure**: how identifiers are declared and used-**binding and scope**-captured by enriching ASTs into **abstract binding trees (ABTs)**.
        
        → Defines precise operations/relations on ABTs to formalize binding and scope - topics that are tricky, bug-prone in implementations.
        

# Abstract syntax trees (ASTs)

## General

- An AST is an **ordered tree**:
    - Leaves: Variables/Operators.
    - Interior nodes: Operators.
        
        Children: Arguments.
        
- An AST is classified into **sorts** corresponding to *different forms of syntax.*
- A **variable** stands for an unspecified, or generic, **piece of syntax** of a specified **sort**.
- **Operator**:
    - Can be used to combine ASTs.
    - Have an **arity** specifying the **sort of the operator** & the **number** and **sorts of its arguments**.
    
    Example: An operator of **sort** $s$ and **arity** $s_1, \dots, s_n$ combines $n \geq 0$ AST's of sort $s_1, \dots , s_n$, respectively, into a compound AST of sort $s$.
    

## Variables

- Definition: An **unknown object** drawn from a domain.
- The ***unknown can become known*** by **substitution** of a particular object for all occurrences of a variable in a formula.
    
    → Specializing a general formula to a particular instance.
    

## Sorts

- [Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast)s are classified by **sorts** that divide ASTs into Syntactic categorys.
- Example 1
    
    Familiar programming languages often have a *syntactic distinction* between **expressions** and **commands**.
    
    → 2 sorts of abstract syntax trees.
    
    → Variables in abstract syntax trees range over Sorts in the sense that only AST's of the specified sort of the variable can be plugged in for that variable.
    
    → It would make no sense to replace an expression variable by a command, nor a command variable by an expression, the two being different sorts of things.
    
- Example 2
    
    A language of arithmetic expressions built from numbers, addition, multiplication.
    
    The abstract syntax:
    
    - An **operator** $\text{num}[n]$ of sort $\text{Exp}$ for each number $n \in \mathbb{N}$.
    - Two **operators**, $\text{times}$ and $\text{plus}$, each of sort $\text{Exp}$, each with two arguments of sort $\text{Exp}$.
    
    → $2 + (3 \times x)$ has the abstract syntax $\text{plus}(\text{num}[2];\ \text{times}(\text{num}[3]; x))$.
    
    → If $x$ has sort $\text{Exp}$, then $\text{plus}(\text{num}[2];\ \text{times}(\text{num}[3]; x))$ also has sort $\text{Exp}$.
    
- The tree structure of [Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast) allows Structural induction.
    
    Suppose that we wish to prove that some property $P(a)$ holds for all ASTs $a$ of a given sort. To show this, it is enough to consider all the ways in which $a$ can be generated and show that the property holds in each case under the assumption that it holds for its constituent ASTs (if any).
    

## Precise definitions

- $\mathcal{S}$: A **finite** set of Sorts.
- An Arity has the form $(s_1, \dots , s_n)s$, which specifies the sort $s \in S$ of an Operator taking $n \geq 0$ arguments, each of sort $s_i \in S$.
- Let $\mathcal{O} = \{\ \mathcal{O}_\alpha\ \}$ be an arity-indexed family of disjoint sets of operators $\mathcal{O}_\alpha$ of arity $\alpha$.
- If $o$ is an Operator of Arity $(s_1, \dots , s_n)s$, we say that $o$ has Sort $s$ and has $n$ arguments of sorts $s_1, \dots , s_n$.
- Let $\mathcal{X} = \{\ \mathcal{X}_s \ \}_{s \in \mathcal{S}}$ be a sort-indexed family of disjoint finite sets $\mathcal{X}_s$ of variables $x$ of sort $s$. When $\mathcal{X}$ is clear from context, we say that:
    - A variable $x$ is of sort $s$ if $x \in \mathcal{X}_s$.
    - A $x$ is **fresh for** $\mathcal{X}$, or just **fresh** when $\mathcal{X}$ is understood, if $x \notin \mathcal{X}_s$ for any sort $s$.
- If $x$ is fresh for $\mathcal{X}$ and $s$ is a sort, then $\mathcal{X} , x$ is the family of sets of variables obtained by adding $x$ to $\mathcal{X}_s$.
    
    The notation is ambiguous in that the sort $s$ is not explicitly stated but determined from context.
    
- The family $\mathcal{A}[\mathcal{X}] = \{\ \mathcal{A}[\mathcal{X}]_s\ \}_{s \in \mathcal{S}}$ of **abstract syntax trees** of sort $s$ is the **smallest family** satisfying the following conditions:
    1. A variable of sort $s$ is an AST of sort $s$: if $x \in \mathcal{X}_s$, then $x \in \mathcal{A}[\mathcal{X}]_s$.
    2. Operators combine ASTs: if $o$ is an operator of arity $(s_1, \dots , s_n)s$, and if $a_1 \in \mathcal{A}[\mathcal{X}]_{s_1}, \dots , a_n \in \mathcal{A}[\mathcal{X}]_{s_n}$, then $o(a_1 ; \dots ; a_n) \in \mathcal{A}[\mathcal{X}]_s$.
- Variables are given meaning by **substitution**.
    - If $a \in \mathcal{A}[\mathcal{X}, x]_{s'}$ and $b \in \mathcal{A}[\mathcal{X}]_s$, then $[b/x]a \in \mathcal{A}[\mathcal{X}]_{s'}$ is the result of substituting $b$ for every occurrence of $x$ in $a$.
    - The AST $a$ is called the **target**, and $x$ is called the **subject**, of the **substitution**.
    - Substitution is defined by the following equations:
        1. $[b/x]x = b$ and $[b/x]y = y$ if $x \not= y$.
        2. $[b/x]o(a_1 ; \dots ;a_n) = o([b/x]a_1 ; \dots ;[b/x]a_n)$.
:::tip
Theorem. If $a \in \mathcal{A}[\mathcal{X}, x]$, then for every $b \in \mathcal{A}[\mathcal{X}]$ there exists a unique $c \in \mathcal{A}[\mathcal{X}]$ such that $[b/x]a=c$.
:::

<details>

<summary>Proof</summary>


Base step:

- $a = y$, with $y \in \mathcal{X}$.

Then, $[b/x]a = y$.

→ Trivially hold.

- $a = x$.

Then, $[b/x]a =b$.

→ Trivially hold.


Inductive step: $a = o(a_1; \dots; a_n)$.

Then, $[b/x]a = o([b/x]a_1; \dots;[b/x]a_n) = o(c_1; \dots; c_n)$, where $c_1, \dots,c_n$ are unique.

→ Hold.


</details>

# Abstract binding trees (ABTs)

## General

- Abstract binding tree (ABT) enrichs AST with **the means** to **introduce new variables and symbols** (Bindings), with a **specified range of significance** (Scope).
- The **scope of a binding** **is an ABT** *within which* the **bound identifier can be used**, either as a **place-holder** (in the case of a **variable declaration**) or as **the index of some operator** (in the case of a **symbol declaration**).
    - The **set of active identifiers** can be ***larger*** within **a subtree of an ABT** than it is within the **surrounding tree**.
    - Different subtrees may introduce identifiers with disjoint scopes.
    
    → The crucial principle is that any use of an identifier should be understood as a **reference**, or **abstract pointer**, to its **binding**.
    
    → The choice of identifiers is immaterial, so long as we can always associate a unique binding with each use of an identifier.
    
- Renaming of bound variables is constrained to the extent that it must not alter the reference structure of the expression.
    - Example
        
        The expression $\text{let}\ x\ \text{be}\ 2\ \text{in}\ \text{let}\ y\ \text{be}\ 3\ \text{in}\ x + x$ has a different meaning than the expression $\text{let}\ y\ \text{be}\ 2\ \text{in}\ \text{let}\ y\ \text{be}\ 3\ \text{in}\ y + y$, because the $y$ in the expression $y + y$ in the second case refers to the inner declaration, not the outer one as before.
        
- ABT = AST + binding + scope.
    - Allow an operator to **bind any finite number** (possibly zero) **of variables** in ***each argument***.
    - An **argument to an operator** is called an Abstractor and has the form $x_1, \dots , x_k.a$.
        
        The sequence of variables $x_1, \dots , x_k$ are bound within the ABT $a$.
        
        (When $k$ is zero, we elide the distinction between $.a$ and $a$ itself)
        
    
    Example: The expression $\text{let}\ x\ \text{be}\ a_1\ \text{in}\ a_2$ has the form $\text{let}(a_1; x.a_2)$.
    
    → Clearly specifies that the variable $x$ is bound within $a_2$, and not within $a_1$.
    
- We often write $\vec{x}$ to stand for a finite sequence $x_1, \dots , x_n$ of distinct variables and write $\vec{x}.a$ to mean $x_1, \dots , x_n .a$.
- *To account for binding*, **operators** are assigned **generalized arities** of the form $(v_1, \dots , v_n)s$, which specifies operators of sort $s$ with $n$ arguments of **valence $v_1, \dots, v_n$**.
- A valence $v$ has the form $s_1, \dots , s_k .s$, which specifies:
    - The sort of an argument.
    - The number and sorts of the variables bound within it.
    
    → A sequence $\vec{x}$ of variables is of sort $\vec{s}$ = The two sequences have the same length $k$ and that the variable $x_i$ is of sort $s_i$ for each $1 \leq i \leq k$.
    
- The operator $\text{let}$ has arity $(\text{Exp}, \text{Exp}.\text{Exp})\text{Exp}$.
    
    → $\text{let}$ is of sort $\text{Exp}$ whose:
    
    - First argument is of sort $\text{Exp}$ and binds no variables.
    - Second argument is also of sort $\text{Exp}$ and within which is bound one variable of sort $\text{Exp}$.
- Example: $\text{let}\ x\ \text{be}\ 2 + 2\ \text{in}\ x \times x$ = $\text{let}(\text{plus}(\text{num}[2];\text{num}[2]); x.\text{times}(x;x))$.

## Precise definitions

- Fix a set $\mathcal{S}$ of sorts and a family $\mathcal{O}$ of disjoint sets of operators indexed by their generalized arities.
- For a given family of disjoint sets of variables $\mathcal{X}$, $\mathcal{B}[\mathcal{X}]$ is the family of ABTs.
    
    This is surprisingly hard to make precise.
    
    - The first definition attempt
        
        $\mathcal{B}[\mathcal{X}]$ is the least family of sets closed under the following conditions:
        
        1. If $x \in \mathcal{X}_s$ , then $x \in \mathcal{B}[\mathcal{X}]_s$.
        2. For each operator $o$ of arity $(\vec{s_1}.s_1, \dots , \vec{s_n} .s_n)s$, if $a_1 \in \mathcal{B}[\mathcal{X}, \vec{x_1} ]_{s_1}$, ..., and $a_n \in \mathcal{B}[\mathcal{X}, \vec{x_n}]_{s_n}$, then $o(\vec{x_1}.a_1 ; \dots ;\vec{x_n}.a_n) \in \mathcal{B}[\mathcal{X}]_s$.
        
        → Almost correct, but fails to account for renaming of bound variables: If $x \in \mathcal{X}$, then we cannot introduce another $x$.
        
        → An ABT of the form $\text{let}(a_1 ; x.\text{let}(a_2 ; x.a_3 ))$ is **ill-formed** *according to this definition*, because the first binding adds $x$ to $\mathcal{X}$, which implies that the second cannot also add $x$ to $\mathcal{X}, x$, because it is not fresh for $\mathcal{X} , x$.
        
        → Goal: Ensure that each of the arguments is well-formed regardless of the choice of bound variable names.
        
        → Achieved using **fresh renaming** - a bijection between sequences of variables.
        

- A **fresh renaming** (relative to $\mathcal{X}$) of a finite sequence of variables $\vec{x}$ is a bijection $\rho : \vec{x} \leftrightarrow \vec{x}'$ between $\vec{x}$ and $\vec{x}'$, where $\vec{x}'$ is fresh for $\mathcal{X}$.
    
    → $\hat{\rho}(a)$ is the result of replacing each occurrence of $x_i$ in $a$ by $\rho(x_i)$, its fresh counterpart.
    
- $\mathcal{B}[\mathcal{X}]$ is the least family such that:
    1. If $x \in \mathcal{X}_s$ then $x \in \mathcal{B}[\mathcal{X}]_s$.
    2. For each operator $o$ of arity $(\vec{s_1}.s_1, \dots, \vec{s_n}.s_n)s$, if for each $1 \le i \le n$ and each fresh renaming $\rho_i:\vec{x}_i \leftrightarrow \vec{x}'_i$, we have $\hat{\rho}_i(a_i) \in \mathcal{B}[\mathcal{X}, \vec{x}_i']$, then $o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n) \in \mathcal{B}[\mathcal{X}]_s$.
    
    → The renaming $\hat{\rho}_i (a_i)$ of each $a_i$ ensures that collisions cannot occur and that the ABT is valid for almost all renamings of any bound variables that occur within it.
    
- The principle of structural induction extends to ABTs and is called Structural induction modulo fresh renaming.
    
    It states that to show that $\mathcal{P}[\mathcal{X}](a)$ holds for every $a \in \mathcal{B}[\mathcal{X}]$, it is enough to show the following:
    
    1. If $x \in \mathcal{X}_s$, then $\mathcal{P}[\mathcal{X}]_s(x)$.
    2. For every $o$ of arity $(\vec{s}_1.s_1; \dots ; \vec{s}_n.s_n)s$, if for each $1 \leq i \leq n$, $\mathcal{P}[\mathcal{X}, \vec{x}'_i]_{s_i}(\hat{\rho}_i(a_i))$ holds for every $\rho_i : \vec{x}_i \leftrightarrow \vec{x}'_i$ with $\vec{x}'_i \notin \mathcal{X}$, then $\mathcal{P}[\mathcal{X}]_s (o(\vec{x}_1.a_1 ; \dots ;\vec{x}_n .a_n))$.
    - Subtlety
        - How does this handle free variables in subterms?
            
            **Question:**
            
            Consider $\lambda x.\ \lambda y.\ y + x$. When applying structural induction at the outer $\lambda x$, we need the induction hypothesis to hold for the subterm $\lambda y.\ y + x$. But in this subterm, $x$ is free. How does the principle account for free variables that arise when we descend under binders?
            
            **Answer:**
            
            The property $\mathcal{P}$ is parameterized by a set of variables $\mathcal{X}$, written $\mathcal{P}[\mathcal{X}]$. This parameter tracks which free variables are "permitted" in the terms under consideration.
            
            When you descend under the binder $\lambda x$, the principle applies a fresh renaming $\rho : x \leftrightarrow x'$ where $x' \notin \mathcal{X}$. The induction hypothesis then states that $\mathcal{P}[\mathcal{X}, x']$ holds for the renamed subterm $\lambda y.\ y + x'$.
            
            The key insight: the extended parameter set $\mathcal{X} \cup \{x'\}$ now includes $x'$, legitimizing its occurrence as a free variable in the subterm. So the induction hypothesis isn't required to hold for subterms with arbitrary free variables-only for subterms whose free variables are contained in the extended set $\mathcal{X} \cup \{x'\}$.
            
            This is precisely what the notation $\mathcal{P}[\mathcal{X}, \vec{x}'_i]_{s_i}(\rho_i(a_i))$ expresses: the property relativized to a variable set that has been extended with the fresh renamings of the bound variables.
            

- **α-equivalence:** The relation $a =_\alpha b$ means that $a$ and $b$ are identical up to the choice of bound variable names.
    
    The α-equivalence relation is the **strongest congruence** containing the following two conditions:
    
    - $x =_\alpha x$.
    - $o(\vec{x}_1.a_1; \ldots; \vec{x}_n.a_n) =_\alpha o(\vec{x}'_1.a'_1; \ldots; \vec{x}'_n.a'_n)$ if for every $1 \leq i \leq n$, $\hat{\rho}_i(a_i) =_\alpha \hat{\rho}'_i(a'_i)$ for all fresh renamings $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho'_i : \vec{x}'_i \leftrightarrow \vec{z}_i$.
    
    The idea is that:
    
    1. We rename $\vec{x}_i$ and $\vec{x}'_i$ consistently to common fresh names, avoiding confusion.
    2. We check that $a_i$ and $a'_i$ *are **α-equivalent**.*
- *If $a =_\alpha b$*, then $a$ and $b$ are α-variants of each other.

- **Substitution:** The substitution of an ABT $b$ of sort $s$ for free occurrences of a variable $x$ of sort $s$ in some ABT $a$, written $[b/x]a$, is **partially defined** by:
    - $[b/x]x = b$, and $[b/x]y = y$ if $x \neq y$.
    - $[b/x]o(\vec{x}_1.a_1; \ldots; \vec{x}_n.a_n) = o(\vec{x}_1.a'_1; \ldots; \vec{x}_n.a'_n)$, where for each $1 \leq i \leq n$, we require that $\vec{x}_i \notin b$, and we set $a'_i = [b/x]a_i$ if $x \notin \vec{x}_i$, and $a'_i = a_i$ otherwise.
    - **Pitfall 1 - bound variables block substitution**
        
        If $x$ is bound by an abstractor within $a$, then $x$ does not occur free within the abstractor and hence is unchanged by substitution.
        
        For example, $[b/x]\text{let}(a_1; x.a_2) = \text{let}([b/x]a_1; x.a_2)$, there being no free occurrences of $x$ in $x.a_2$.
        
    - **Pitfall 2 - variable capture**
        
        If $y \in b$ and $x \neq y$, then $[b/x]\text{let}(a_1; y.a_2)$ is undefined, rather than being $\text{let}([b/x]a_1; y.[b/x]a_2)$.
        
        For example, provided that $x \neq y$, $[y/x]\text{let}(\text{num}[0]; y.\text{plus}(x; y))$ is undefined, not $\text{let}(\text{num}[0]; y.\text{plus}(y; y))$, which confuses two different variables named $y$.
        
- **Avoiding capture:** Capture can always be avoided by first renaming the bound variables in $a$ to avoid any free variables in $b$.
    
    Example: If we rename the bound variable $y$ to $y'$ to obtain $a' = \text{let}(\text{num}[0]; y'.\text{plus}(x; y'))$, then $[y/x]a'$ is defined and equals $\text{let}(\text{num}[0]; y'.\text{plus}(y; y'))$.
    
    The price is that substitution is only determined up to α-equivalence.
    
- **The identification convention:** Abstract binding trees are always identified up to α-equivalence.
    
    That is, α-equivalent ABTs are regarded as identical.
    
    Substitution can be extended to α-equivalence classes by choosing representatives such that substitution is defined, then forming the equivalence class of the result.
    
    Any two valid choices give α-equivalent results, so substitution becomes a well-defined total function.
    
- **Symbols:**
    - Motivation: It will often be necessary to consider languages whose abstract syntax cannot be specified by a fixed set of operators but rather requires that the available operators be sensitive to the context in which they occur.
    - A **symbolic parameter**, or **symbol**, indexes families of operators.
    - An **indexed operator** $o$ is a family of operators indexed by symbols $u$, so that $o[u]$ is an operator when $u$ is an available symbol.
    - If $U$ is a finite set of symbols, then $\mathcal{B}[U; \mathcal{X}]$ is the family of ABTs generated by operators and variables, admitting all indexed operator instances by symbols $u \in U$.
        - A variable is a placeholder that stands for **an unknown ABT of its sort**.
        - A symbol does not stand for anything and is not itself an ABT.
            
            The only significance of a symbol is whether it is the same as or differs from another symbol.
            
    - The set of symbols is extended by introducing a new, fresh symbol within a scope using the abstractor $u.a$, which binds the symbol $u$ within the ABT $a$.
    - The only difference between symbols and variables is that the only operation on symbols is **renaming**; there is no notion of substitution for a symbol.

- **Notation convention:** Arguments to operators can be visually grouped using braces and parentheses (e.g., $o\{a_1; a_2\}(a_3; x.a_4)$), with stages progressing right to left. This is purely a readability aid-it has no semantic significance. The grouped form is identical to the flat form $o(a_1; a_2; a_3; x.a_4)$.

- **Historical notes:**
    - Abstract syntax originates with Church, Turing, and Gödel, who first considered programs acting on representations of programs.
    - Programs were initially encoded as natural numbers via Gödel-numberings based on prime factorization [Kleene, 1952].
    - Lisp introduced a more practical representation as symbolic expressions [McCarthy, 1965; Allen, 1978].
    - ML added a type system capable of expressing abstract syntax trees [Gordon et al., 1979].
    - AUTOMATH introduced using Church's λ notation to handle binding and scope [Church, 1941; Nederpelt et al., 1994], developed further in LF [Harper et al., 1993].
    - Abstract binding trees here were inspired by NuPRL's notation [Constable, 1986] and Martin-Löf's system of arities [Nordström et al., 1990].
    - Symbol binders are influenced by [Pitts and Stark, 1993].

# Exercises

## Exercise 1.1

**Problem statement.** Prove by structural induction on abstract syntax trees that if $\mathcal{X} \subseteq \mathcal{Y}$, then $\mathcal{A}[\mathcal{X}] \subseteq \mathcal{A}[\mathcal{Y}]$.

<details>

<summary>Proof</summary>


Consider an AST $a_\mathcal{X} \in \mathcal{A}[\mathcal{X}]$. We will prove that $a_\mathcal{X} \in \mathcal{A}[\mathcal{Y}]$.

- If $a_\mathcal{X} \in \mathcal{X}$ then $a_\mathcal{X} \in \mathcal{Y} \subseteq \mathcal{A}[\mathcal{Y}]$.
- If $a_\mathcal{X} = o(x_1; \dots; x_n)$, then by the induction hypothesis, $x_i \in \mathcal{A}[\mathcal{Y}]$. By definition, $a_\mathcal{X} = o(x_1;\dots; x_n) \in \mathcal{A}[\mathcal{Y}]$.

Therefore, $\mathcal{A}[\mathcal{X}]\subseteq \mathcal{A}[\mathcal{Y}]$.


</details>

## Exercise 1.2

**Problem statement.** Prove by structural induction modulo renaming on abstract binding trees that if $\mathcal{X} \subseteq \mathcal{Y}$, then $\mathcal{B}[\mathcal{X}] \subseteq \mathcal{B}[\mathcal{Y}]$.

<details>

<summary>Proof</summary>


Given two sets of variables $\mathcal{X}$ and $\mathcal{Y}$, for an ABT $b \in \mathcal{B}[\mathcal{X}]$, denote $P[\mathcal{X}, \mathcal{Y}](b) = b \in \mathcal{B}[\mathcal{Y}]$.

We'll prove that $\mathcal{X} \subseteq \mathcal{Y}$ implies $\forall b\in \mathcal{B}[\mathcal{X}].\ P[\mathcal{X}, \mathcal{Y}](b)$. 

We perform induction on the structure of $b \in \mathcal{B}[\mathcal{X}]$:

- If $b \in \mathcal{X}$, it's obvious that $P[\mathcal{X}, \mathcal{Y}](b)$, for all $\mathcal{X}\subseteq \mathcal{Y}$.
- Suppose $b = o(\vec{x}_1.a_1;\dots;\vec{x}_n.a_n)$.

Consider a fresh renaming $\rho_i : \vec{x}_i \leftrightarrow \vec{x}'_i$ relative to both $\mathcal{X}$ and $\mathcal{Y}$.

It's trivial to see that $\mathcal{X} \cup \vec{x}_i' \subseteq \mathcal{Y} \cup \vec{x}_i'$ and $\hat{\rho}_i(a_i) \in \mathcal{B}[\mathcal{X}]$.

The induction hypothesis is that $P[\mathcal{X} \cup \vec{x}'_i, \mathcal{Y} \cup \vec{x}'_i](\hat{\rho_i}(a_i))$, or $\hat{\rho}_i(a_i)\in \mathcal{B}[\mathcal{Y}]$.

By definition, $b \in \mathcal{B}[\mathcal{Y}]$.


</details>

## Exercise 1.3

**Problem statement.** Show that if $a =_\alpha a'$ and $b =_\alpha b'$ and both $[b/x]a$ and $[b'/x]a'$ are defined, then $[b/x]a =_\alpha [b'/x]a'$.

<details>

<summary>Proof</summary>


By definition, $[b/x]a$ and $[b'/x]a'$ are defined.

- If $a = x \in \mathcal{X}$, then $a' = x$.

Therefore, $[b/x]a = b =_\alpha b' = [b'/x]a'$.

- If $a = y \in \mathcal{X}$ and $x \neq y$, then $a' = y$.

Therefore, $[b/x]a = a = [b'/x]a'$.

- If $a = o(\vec{x}_1.a_1;\dots;\vec{x}_n.a_n)$, then $a' = o(\vec{x}'_1.a_1';\dots;\vec{x}'_n.a_n')$, such that for all $1 \le i \le n$, $\hat{\rho}_i(a_i) =_\alpha \hat{\rho}_i'(a_i')$ for all fresh renamings $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho'_i : \vec{x}'_i \leftrightarrow \vec{z}_i$.

Because $[b/x]a$ is defined, we have $\vec{x}_i \notin b$, and similarly, $\vec{x}_i' \notin b'$.

Therefore, $[b/x]a = o(\vec{x}_1. c_1;\dots;\vec{x}_n.c_n)$, where $c_i = [b/x]a_i$ if $x \notin \vec{x}_i$, or $c_i = a_i$ otherwise.

Similarly, $[b'/x]a' = o(\vec{x}'_1. c'_1;\dots;\vec{x}'_n.c'_n)$, where $c'_i = [b'/x]a'_i$ if $x \notin \vec{x}'_i$, or $c'_i = a'_i$ otherwise.

By induction, $[b/x]a =_\alpha [b'/x]a'$.


</details>

## Exercise 1.4

**Problem statement.** Bound variables can be seen as the formal analogs of pronouns in natural languages. The binding occurrence of a variable at an abstractor fixes a "fresh" pronoun for use within its body that refers unambiguously to that variable (in contrast to English, in which the referent of a pronoun can often be ambiguous). This observation suggests an alternative representation of ABTs, called *abstract binding graphs*, or ABG*s* for short, as directed graphs constructed as follows:

(a) Free variables are atomic nodes with no outgoing edges.

(b) Operators with $n$ arguments are $n$-ary nodes, with one outgoing edge directed at each of their children.

(c) Abstractors are nodes with one edge directed to the scope of the abstracted variable.

(d) Bound variables are back edges directed at the abstractor that introduced it.

Notice that ASTs, thought of as ABTs with no abstractors, are *acyclic* directed graphs (more precisely, variadic trees), whereas general ABTs can be *cyclic*. Draw a few examples of ABGs corresponding to the example ABTs given in this chapter. Give a precise definition of the sort-indexed family $\mathcal{G}[\mathcal{X}]$ of abstract binding graphs. What representation would you use for bound variables (back edges)?

<details>

<summary>Proof</summary>


</details>

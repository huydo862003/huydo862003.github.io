---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 3. untyped arithmetic expressions
author: Benjamin C. Pierce
date: ""
journey: plt
tags: []
concepts:
  - term
  - BNF
  - metavariable
  - program
  - metalanguage
  - object-language
  - metatheory
  - term-expression
  - meta-mathematics
  - structural-abstract-syntax-concrete-surface-syntax
  - untyped-calculus-of-booleans-and-numbers-nonsensical-term
  - value
  - inductive-definition-term
  - logical-system
  - natural-deduction-style
  - axiom-inference-rule
  - rule-schema-inference-rule-concrete-rule-instance-of-an
  - inductive-definition-2-dimensional-inference-rule-format
  - structural-induction
  - small-step-structural-operational-semantics-sos
  - operational-semantics
  - denotational-semantics
  - axiomatic-semantics
  - big-step-natural-operational-semantics-small-step
  - term-value
  - evaluation-reduction-relation
  - evaluation-strategy
  - computation-rule-congruence-rule
  - instance-of-an-inference-rule
  - inference-rule
  - one-step-evaluation-relation
  - derivable-evaluation-statement-judgement
  - evaluation-reduction-relation-derivable
  - induction-on-derivations
  - normal-form
  - normal-form-value
  - stuck-term-value-normal-form
  - desired-property-termination-of-evaluation-desired-property
  - desired-property-determinacy-of-one-step-evaluation
  - untyped-calculus-of-booleans-and-numbers
  - operational-semantics-untyped-calculus-of-booleans-and
  - pure-untyped-lambda-calculus-runtime-error-stuck-term
  - pure-untyped-lambda-calculus-syntactic-category
parent: part-i-untyped-systems
children: []
---

# Summary of desirable properties for a system

- Determinacy of the single-step evaluation relation.
    
    Should hold for all systems.
    
- Uniqueness of normal-forms.
    
    Should hold for all systems.
    
- Values are normal forms.
    
    Should hold for all systems.
    
- Normal forms are values.
    
    May not hold for all systems.
    
- Termination of evaluation.
    
    May not hold for all systems.
    

# Introduction

The convention used is similar to the standard BNF [cf. Aho, Sethi, and Ullman, 1986].


```
t  ::=          terms:
       true         constant true
       false        constant false
       if t then t else t   conditional
       0            constant zero
       succ t       successor
       pred t       predecessor
       iszero t     zero test
```

A simple untyped expression language - **Untyped calculus of booleans and numbers**

- Syntactically, this language comprises of:
    - The **boolean constants** `true` and `false`.
    - **Conditional expressions** (`if` expression).
    - The **numeric constant** `0`.
    - The **arithmetic operators** `succ` (successor) and `pred` (predecessor).
    - A **testing operation** `iszero` that returns true when it is applied to 0, and false when it is applied to some other number.
- Abstract syntax notation
    - **Term definition ($\text{t} ::= \ldots$):** The notation $\text{t} ::=$ declares **the set of terms**, with the letter $\text{t}$ (and variants like $\text{s}, \text{u}, \text{t}_1$) used as a **metavariable** to range over terms.
    - **Metavariable:** $\text{t}$ is a **placeholder** for a particular term of the **object language**, but belongs to the **metalanguage** (the language used for description).
        - This concept is borrowed from **meta-mathematics**, giving rise to the term **metatheory** (the formal study of a logical system's properties).
        - The prefix **meta-** comes from **meta-mathematics**, the subfield of logic whose subject matter is the mathematical properties of systems for mathematical and logical reasoning.
        - **Metatheory**: The collection of true statements that we can make about some particular logical system (or programming language)-and, by extension, the study of such statements.
            
            → Phrases like "**metatheory of subtyping**" can be understood as "**the formal study of the properties of systems with subtyping**".
            
    - A **program** is simply a **term** built from the forms defined in the grammar.
    - The symbol $\to$ is used to display the result of evaluating an example term.
        - *Example:* `if false then 0 else 1` $\to$ `1`.
    - **Terms** vs **expressions:**
        - Currently, **term** and **expression** are interchangeable.
        - Starting in Chapter 8:
            - **Expression** will be used for all syntactic phrases (terms, types, kinds). For calculi with additional **syntactic categories** such as **types**, **expression** is used for all sorts of syntactic phrases (including term expressions, type expressions, kind expressions,
            etc.)
            - **Term** will be reserved for phrases representing **computations** (i.e., phrases that can substitute for $\text{t}$).
    - **Values:**
        - The results of evaluation are terms of a simple form: **boolean constants** or **numbers** (nested `succ` applications to `0`).
        - Values play a special role in formalizing evaluation order.
    - **Abstract** vs **concrete syntax:** Parentheses (e.g., in `iszero(pred(succ 0))`) are used for readability but are **not part of the grammar's abstract syntax**, which is currently unambiguous.
    - **"Nonsensical" terms:**
        - The syntax permits terms that are semantically dubious (e.g., `succ true` or `if 0 then 0 else 0`).
        - These terms are what make the simple language interesting, as the goal of the type system is precisely to **exclude** such ill-formed programs.

# Syntax

- There are more than one way to describe a syntax of a language.
    - The BNF notation above.
    - Inductive definition (more verbose).
        
        The set of terms ($\mathcal{T}$) is the smallest set such that:
        
        1. $\{\text{true}, \text{false}, 0\} \subseteq \mathcal{T}$.
        2. If $\text{t}_1 \in \mathcal{T}$, then $\{\text{succ } \text{t}_1, \text{pred } \text{t}_1, \text{iszero } \text{t}_1\} \subseteq \mathcal{T}$ .
        3. If $\text{t}_1 \in \mathcal{T}, \text{ t}_2 \in \mathcal{T}, \text{ and } \text{t}_3 \in \mathcal{T}$, then $\text{if } \text{t}_1 \text{ then } \text{t}_2 \text{ else } \text{t}_3 \in \mathcal{T}$.
        - Structure of the definition
            - Clause 1 specifies **base elements** (`true`, `false`, `0`).
            - Clause 2 specifies **rules** for building **compound expressions** (`succ t1`, `if t1 then t2 else t3`, etc.) from existing terms.
            - **"Smallest set":** This crucial phrase ensures that T contains **no elements** other than those absolutely required by the construction rules in the preceding clauses.
        - Formally, the definition defines T as a set of **trees**, not a set of linear strings.
        - The use of **parentheses** in written examples (the linear form) serves merely to clarify the underlying **tree structure** (the abstract syntax) of compound subterms.
    - 2-dimensional inference rule format.
        - A different shorthand for the same inductive definition of terms.
        - Commonly used in "natural deduction style" presentations of logical systems.
        
        - Each rule is read, "If we have established the statements in the premise(s) listed above the line, then we may derive the conclusion below the line."
        - The fact that $T$ is the smallest set satisfying these rules is often (as here) not stated explicitly.
        - **Inference rule (generic term):** The term **inference rule** is used generically throughout the book to refer to **any rule in the system**, including both **axioms** and **rules with one or more premises**.
        - **Axioms:** Rules with **no premises** (like the first three base cases for true, false, and 0). They are often written **without the horizontal bar**.
        - **Rule schemas (formal terminology):** What are called "inference rules" are technically **rule schemas** because their premises and conclusions contain **metavariables** (`t1`, `t2`, etc.).
            - Each schema formally represents an **infinite set of concrete rules** that are obtained by consistently replacing the metavariables with all possible phrases from the appropriate syntactic category (e.g., replacing t with every possible term).
    - Concrete generator notation.
        - More "concrete" style that gives an explicit procedure for generating the elements of $T$.
        
        - Exercise 3.2.4
            
            **Task**: How many elements does $S_3$ have?
<details>
<summary>Solution</summary>


Take $l_i = | S_i |$ for any $i \ge 0$.

Then, $l_{i+1} = 3 + 3l_i + l_i^3$.

- $l_0 = 0$.
- $l_1 = 3$.
- $l_2 = 3 + 9 + 3^3 = 39$.
- $l_3 = 3 + 3*39 + 39^3 = ...$
</details>
        - Exercise 3.2.5
            
            **Task**. Show that the sets $S_i$ are **cumulative**-that is, that for each i
            we have $S_i \subseteq S_{i+1}$.
<details>
<summary>Solution</summary>


- It's obvious that $S_0 \subseteq S_1$.
- Suppose that $S_{i-1} \subseteq S_i$  for some $i > 0$.

Then:




$$
S_{i+1} = \begin{array}{l}
\{\text{true}, \text{false}, 0\} \\
\cup\, \{\text{succ } t_1, \text{pred } t_1, \text{iszero } t_1 \mid t_1 \in S_i\} \\
\cup\,  \{\text{if } t_1 \text{ then } t_2 \text{ else } t_3 \mid t_1, t_2, t_3 \in S_i\}.
\end{array}
$$
\implies S_{i+1} = \begin{array}{l}
\{\text{true}, \text{false}, 0\} \\
\cup\, \{\text{succ } t_1, \text{pred } t_1, \text{iszero } t_1 \mid t_1 \in S_{i-1}\} \\
\cup\,  \{\text{if } t_1 \text{ then } t_2 \text{ else } t_3 \mid t_1, t_2, t_3 \in S_{i-1}\}\\
\cup\, \{\text{succ } t_1, \text{pred } t_1, \text{iszero } t_1 \mid t_1 \in S_i\} \\
\cup\,  \{\text{if } t_1 \text{ then } t_2 \text{ else } t_3 \mid t_1, t_2, t_3 \in S_i\}.
\end{array}
$$
\implies S_{i+1} = \begin{array}{l}
S_i\\
\cup\, \{\text{succ } t_1, \text{pred } t_1, \text{iszero } t_1 \mid t_1 \in S_i\} \\
\cup\,  \{\text{if } t_1 \text{ then } t_2 \text{ else } t_3 \mid t_1, t_2, t_3 \in S_i\}.
\end{array}
$$


Therefore, $S_i \subseteq S_{i+1}$.

- The inductive definition and inference rule format characterize the set as the **smallest set** satisfying **certain "closure properties"**.
- The concrete generator notation shows **how to actually construct the set as the limit of a sequence**.
- Proof that the **inductive definition/inference rule format** produce the *same language* as **the concrete generator notation**.

**Proposition:** $\mathcal{T} = S$.

Because $\mathcal{T}$ is the smallest set satisfying *certain conditions*, it suffices to show that:

- $S$ satisfies these conditions.
- *Any set satisfying the conditions* has $S$ as a subset (i.e., that $S$ is the smallest set satisfying the conditions).
- $S \subseteq \mathcal{T}$ ($S$ is the smallest set)

The goal is to show that $S$ is a subset of $\mathcal{T}$ (i.e., $S \subseteq \mathcal{T}$).

- This part checks that $\mathcal{T}$ satisfies the three conditions in Definition 3.2.1.
- **Constants:** It is clear that the constants $\{\text{true}, \text{false}, 0\}$ are in $S$. Since $\mathcal{T}$ is closed under the structural rules, the constants are in $\mathcal{T}$.
- **Unary operators:** By the definition of $S_{i+1}$, if $t_1 \in S$, then $\text{succ } t_1 \in S$. But since $\mathcal{T}$ is closed under the `succ` rule, then $\text{succ } t_1$ must also be in $\mathcal{T}$. The same applies to $\text{pred } t_1$ and $\text{iszero } t_1$.
- **Ternary operator:** Similarly, if $t_1, t_2, t_3 \in S$, then $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$ is in $S$, and by the closure of $\mathcal{T}$ under the `if` rule, it must be in $\mathcal{T}$.
- Since $\mathcal{T}$ satisfies the three conditions in Definition 3.2.1, and $S$ is defined to be the set of elements formed by repeated application of these conditions (hence $S \subseteq S'$ for any set $S'$ satisfying the conditions), it follows immediately that $S \subseteq \mathcal{T}$.
- $\mathcal{T} \subseteq S$ (using complete induction)

The goal is to show that $\mathcal{T}$ is a subset of $S$ (i.e., $\mathcal{T} \subseteq S$).

- This part uses **complete induction on $i$** to argue that every set $S_i$ is a subset of $S'$ (a set satisfying the three conditions).
- Let $S'$ be the smallest set satisfying the three conditions (i.e., $S' = \mathcal{T}$).
- **Base case:** For $i=0$, $S_0 = \emptyset$. Since $\emptyset \subseteq \mathcal{T}$ trivially, the base case holds.
- **Inductive case:** Suppose $S_j \subseteq \mathcal{T}$ for all $j < i$ (or $j=i$ if we let the induction proceed on $i=j+1$). We must show that $S_{i+1} \subseteq \mathcal{T}$.
- Any element $t$ of $S_{i+1}$ must come from one of the following three sets of possibilities (corresponding to the definition of $S_{i+1}$):
1. If $t$ is a constant ($\text{true}$, $\text{false}$, or $0$), then $t \in \mathcal{T}$ by condition 1.
2. If $t$ has the form $\text{succ } t_1$, $\text{pred } t_1$, or $\text{iszero } t_1$, then $t_1 \in S_i$. By the induction hypothesis, $t_1 \in \mathcal{T}$. Since $\mathcal{T}$ satisfies condition 2 (closure under constructors), $t \in \mathcal{T}$.
3. If $t$ has the form $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$, then $t_1, t_2, t_3 \in S_i$. By the induction hypothesis, $t_1, t_2, t_3 \in \mathcal{T}$. Since $\mathcal{T}$ satisfies condition 3 (closure under the `if` constructor), $t \in \mathcal{T}$.
- Thus, we have shown that each $S_i \subseteq \mathcal{T}$. By the definition of $S$ as $\bigcup_i S_i$, this completes the argument that $S \subseteq \mathcal{T}$.
- Insight
- It is worth noting that the proof uses **complete induction on the natural numbers** $i$, which is *not* the more familiar "base case/induction case" form.
- In complete induction, one proves that the desired predicate holds for all numbers *strictly less than* $i$ and uses that to prove that it holds for $i$.
- In essence, every step here is an induction step; the only thing that is special about the case where $i=0$ is that the set of smaller values of $i$ for which the induction hypothesis can be invoked happens to be empty.
- The same remark will apply to most induction proofs throughout the book, particularly proofs by **"structural induction"**.

</details>

# Induction on terms

- The **explicit characterization of the set of terms $S$** in Proposition 3.2.6 justifies an important principle for **reasoning about its elements** based on **its structure**.
    
    If $t \in T$, then one of three things must be true about $t$:
    
    1. $t$ is a constant.
    2. $t$ has the form $\text{succ } t_1$, $\text{pred } t_1$, or $\text{isZero } t_1$ for some **smaller** term $t_1$.
    3. $t$ has the form $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$ for some **smaller** terms $t_1, t_2$, and $t_3$.
    
    \to This observation can be applied in 2 ways:
    
    - **Inductive definitions** of functions can be given **over the set of terms**.
    - **Inductive proofs** of properties of terms can be given.

\to Structural induction.

## $\text{Consts}(t)$

The **set of constants** *appearing in a term $t$*, written $\text{Consts}(t)$, is defined as follows:

| **Term** $t$ | $\text{Consts}(t)$ **definition** |
 | --- |  ---  |
| $\text{true}$ | $= \{\text{true}\}$ |
 | $\text{false}$ | $= \{\text{false}\}$ | 
 | $0$ | $= \{0\}$ | 
 | $\text{succ } t_1$ | $= \text{Consts}(t_1)$ | 
 | $\text{pred } t_1$ | $= \text{Consts}(t_1)$ | 
 | $\text{isZero } t_1$ | $= \text{Consts}(t_1)$ | 
| $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$ | $= \text{Consts}(t_1) \cup \text{Consts}(t_2) \cup \text{Consts}(t_3)$ |

## $\text{size}(t)$

The **size** of a term $t$, written $\text{size}(t)$, is defined as follows:

| **Term** $t$ | $*\text{size}(t)$ d***efinition** |
 | --- |  ---  |
| $\text{true}$ | $= 1$ |
 | $\text{false}$ | $= 1$ | 
 | $0$ | $= 1$ | 
 | $\text{succ } t_1$ | $= \text{size}(t_1) + 1$ | 
 | $\text{pred } t_1$ | $= \text{size}(t_1) + 1$ | 
 | $\text{isZero } t_1$ | $= \text{size}(t_1) + 1$ | 
| $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$ | $= \text{size}(t_1) + \text{size}(t_2) + \text{size}(t_3) + 1$ |

That is, the size of $t$ is the number of nodes in its abstract syntax tree. 

## $\text{depth}(t)$

The **depth** of a term $t$, written $\text{depth}(t)$, is defined as follows:

| **Term** $t$ | $\text{depth}(t)$ **definition** |
 | --- |  ---  |
| $\text{true}$ | $= 1$ |
 | $\text{false}$ | $= 1$ | 
 | $0$ | $= 1$ | 
 | $\text{succ } t_1$ | $= \text{depth}(t_1) + 1$ | 
 | $\text{pred } t_1$ | $= \text{depth}(t_1) + 1$ | 
 | $\text{isZero } t_1$ | $= \text{depth}(t_1) + 1$ | 
| $\text{if } t_1 \text{ then } t_2 \text{ else } t_3$ | $= \max(\text{depth}(t_1), \text{depth}(t_2), \text{depth}(t_3)) + 1$ |

Equivalently, $\text{depth}(t)$ is the smallest $i$ such that $t \in S_i$, according to Definition 3.2.3.

## Lemma: The number of distinct constants

**Statement**. The number of distinct constants in a term $t$ is no greater than the size of $t$ (i.e., $| \text{Consts}(t) | \le \text{size}(t)$).

<details>

<summary>Proof</summary>


By induction on the depth of $t$.

Assuming the desired property for all terms smaller than $t$, we must prove it for $t$ itself.

There are three cases to consider:

**Case:** $t$ **is a constant**

- Immediate: $| \text{Consts}(t) | = | \{t\} | = 1 = \text{size}(t)$.

**Case: $t = \text{succ } t_1 \lor t =  \text{pred } t_1 \lor t =  \text{isZero } t_1$**

- By the induction hypothesis, $| \text{Consts}(t_1) | \le \text{size}(t_1)$.
- We now calculate as follows:

$$
|  \text{Consts}(t) |  = |  \text{Consts}(t_1) |  \le \text{size}(t_1) < \text{size}(t)
$$


**Case: $t = \text{if } t_1 \text{ then } t_2 \text{ else } t_3$**

- By the induction hypothesis, $\vert  \text{Consts}(t_1) \vert  \le \text{size}(t_1)$, $\vert  \text{Consts}(t_2) \vert  \le \text{size}(t_2)$, and $\vert  \text{Consts}(t_3) \vert  \le \text{size}(t_3)$.
- We now calculate as follows:

$$
\begin{aligned} \vert  \text{Consts}(t) \vert  &= \vert  \text{Consts}(t_1) \cup \text{Consts}(t_2) \cup \text{Consts}(t_3) \vert  \\ &\le \vert  \text{Consts}(t_1) \vert  + \vert  \text{Consts}(t_2) \vert  + \vert  \text{Consts}(t_3) \vert  \\ &\le \text{size}(t_1) + \text{size}(t_2) + \text{size}(t_3) \\ &< \text{size}(t)\end{aligned}
$$


</details>

## General reasoning principle - Generalization of the previous lemma's proof structure

- **Theorem [Principles of induction on terms]:** Suppose $P$ is a predicate on terms.
    
    ***Induction on depth**:*
    
    If, for each term $s$, given $P(r)$ for all $r$ such that $depth(r) < depth(s)$, we can show  $P(s)$, then $P(s)$ holds for all $s$.
    
    ***Induction on size**:*
    
    If, for each term $s$, given $P(r)$ for all $r$ such that $size(r) < size(s)$, we can show  $P(s)$, then $P(s)$ holds for all $s$.
    
    ***Structural induction**:*
    
    If, for each term $s$, given $P(r)$ for all immediate subterms $r$ of $s$ **we can show $P(s)$, then $P(s)$ holds for all $s$.
    
<details>

<summary>Proof</summary>


</details>

# Semantic styles

- How to formulate the **semantics of a language** precisely?
- Three basic approaches to semantics formalization:
    - **Operational semantics**
        - Idea: Define a simple **abstract machine** for the language.
        - Abstract: The machine directly ses the terms of the language as its machine code.
        - **State** of the machine: For simple languages, it's just a term.
        - **Transition function**: Describe the machine's behavior - for each state, either:
            - Gives the next state by performing a step of **simplification** on the term.
            - Declares that the machine has **halted**.
        - The **meaning** of a term $t$ can be taken to be the final state that the machine reaches when started with $t$ as its initial state.
        - It is sometimes useful to give **two or more different operational semantics** for a single language:
            - Some more abstract, with machine states that look similar to the terms that the programmer writes.
            - Others closer to the structures manipulated by an actual interpreter or compiler for the language.
        
        \to Proving that **the behaviors of these different machines correspond in some suitable sense** when **executing the same program** amounts to **proving the correctness of an implementation of the language**.
        
    - **Denotational semantics**
        - More abstract.
        - The **meaning** of a term: Some mathematical object (number/function) rather than a sequence of machine states.
        - Giving denotational semantics for a language:
            1. Find a collection of **semantic domains**.
            2. Define an **interpretation function** mappings terms into elements of these domains.
            
            \to **Domain theory**: Facilitate the search for appropriate semantic domains for modeling various language features.
            
        - Major advantages of denotational semantics:
            - Abstracts from the **gritty details of evaluation**.
            - Highlights the **essential concepts of the language**.
            - The **properties** of the chosen **collection of semantic domains** can be used to derive **powerful laws** for **reasoning about program behaviors**.
                - Laws for proving that two programs have exactly the same behavior.
                - Laws for that a program's behavior satisfies some specification.
            - From the properties of the chosen collection of semantic domains, it is often immediately evident that various (desirable or undesirable) things are **impossible in a language**.
    - **Axiomatic semantics**
        - **Idea**: Define a language by its **proof rules/laws**, rather than by first defining how programs run (operational) or what they denote mathematically (denotational) and then deriving laws.
        - So the "meaning" of a program/term is **whatever properties you can prove about it** using the axioms and inference rules.
        - Strength: Centers the whole story on **reasoning about programs**, which led to key techniques like **invariants**.
    - A bit of history & comparison
        - **1960s-1970s:** Operational semantics was often seen as *inferior* to denotational and axiomatic semantics-okay for "quick and dirty" feature definitions, but viewed as less elegant and less mathematically strong.
        - **1980s shift:** Denotational/axiomatic approaches ran into tougher technical issues (denotational: nondeterminism & concurrency; axiomatic: procedures), making operational semantics' **simplicity + flexibility** more appealing.
        - **Key developments that boosted operational semantics:**
            - **Structural operational semantics (SOS)** [Plotkin, 1981]
            - **Natural semantics** [Kahn, 1987]
            - **CCS** [Milner, 1980; 1989; 1999]
            
            These introduced cleaner formalisms and helped transfer techniques from denotational semantics into operational settings.
            
        - **Today:** Operational semantics is a major research area and often the **default** method for defining languages and proving properties.

# Evaluation

Operational semantics of boolean expressions

- Three sections in the definition above.
    - The **set of terms**.
    - The **set of values**, a subset of terms (possible final results of evaluation).
        
        \to Just constants `true`  and `false`.
        
        \to The meta variable `v` is often used.
        
    - The **inference rules** for the **evaluation relation**.
        - Written $t \to t'$.
        - Pronounced "$t$ evaluates to $t'$ in one step".
        - Intuition: If $t$ is the state of the abstract machine at a given moment, then the machine can make a step of computation and change its state to $t'$.
        - This relation is defined by **three inference rules** (or, if you prefer, two **axioms** and a **rule**, since the first two have no premises).
- What the **evaluation rules** *do not* say is just **as important as** what they *do say*.
    - The constants `true` and `false` do not evaluate to anything, since they do not appear as the left-hand sides of any of the rules.
    - There is no rule allowing the evaluation of a `then`- or `else`-subexpression of an `if` before evaluating the `if` itself.
    - The *set of evaluation rules*, taken together forces a specific **evaluation order** (strategy).
        - **Congruence rule** = "where to evaluate next" (it propagates evaluation into a subterm; it sets the strategy/order).
        - **Computation rule** = "the actual reduction" (they perform the meaningful work once the guard is a value).

## Intuition formalization

- **Instance of an inference rule**: ****An **instance** of **an inference rule** is obtained by **consistently replacing each metavariable** by **the same term** in the rule's **conclusion** and all its **premises** (if any).
- **Rule satisfied by a relation**: A **rule** is **satisfied** by a **relation** if, for **each instance** of the rule, either **the conclusion is in the relation** or **one of the premises is not**.
    - What does this mean? (ChatGPT)
        - **Setup**
            - A **rule** has **premises** and a **conclusion**.
            - An **instance of a rule** = a concrete version after substituting its metavariables.
            - A **relation** `R` = a **set of judgments** you consider "true" (e.g., `e \to e'`, or `\Gamma \vdash e : \tau`).
        - **Definition**
            
            A rule instance
            
            - Premises: `P1, P2, ..., Pn`
            - Conclusion: `C`
            
            is **satisfied by** a relation `R` iff:
            
            - **either** `C \in R`
            - **or** at least one premise is missing from `R` (i.e., `Pi \notin R` for some `i`)
            
            **In words:**
            
            > You can't have all the premises in R while the conclusion is not in R.
            > 
        - **Equivalent logical form**
            
            **Closure form**
            
            - If all premises are in `R`, then the conclusion must be in `R`.
            
            `(P1 \in R \wedge ... \wedge Pn \in R) \Rightarrow (C \in R)`
            
            **"No counterexample" form**
            
            - There is no rule instance where all premises are in `R` but the conclusion is not.
            
            \neg((P1 \in R \wedge ... \wedge Pn \in R) \wedge (C \notin R))
            
        - **Operational semantics intuition (small-step)**
            
            If the rule is:
            
            - Premise: `e1 \to e1'`.
            - Conclusion: `e1 e2 \to e1' e2`.
            
            Then "`R` satisfies the rule" means: Whenever `e1 \to e1'` is in `R`, `e1 e2 \to e1' e2` must also be in `R`.
            
        
        **Satisfying a rule = being closed under that rule.**
        
- **One-step evaluation relation** `\to`: The `\to` is the **smallest** **binary relation** on terms **satisfying all the inference rules**. When the pair $(t, t')$ is in **the evaluation relation**, we say that "the **evaluation statement** (or **judgment**) $t \to t'$ is **derivable**."
    - Why "smallest"?
        
        Statement $t \to t'$ is **derivable** *iff* it is **justified by the rules**:
        
        - Either it is an instance of one of the axioms.
        - Else it is the conclusion of an instance of rule whose premise is derivable.
- The **derivability** of a given statement can be justified by exhibiting a **derivation tree**.
    - Example
        
        The derivability of:
        
        is witnessed by the following derivation tree:
        
        - The bottom is the root.
        - The top are the leaves.
- An **evaluation statement $t \to t'$** is **derivable** *iff* there is a **derivation tree** with $t \to t'$ as **the label** at its **root**.
    
    \to Often useful when **reasoning about properties** of **the evaluation relation**.
    
    \to A proof technique: **induction on derivations**.
    

## Induction on derivations
:::tip
The main idea is to perform **induction** on **the size of the derivations**.
:::

At each step of the induction:

- Assume the target property holds for all smaller derivations.
- Perform a case analysis of the evaluation rule used at the root of the derivation.

\to We're looking at a single step of evaluation.

### Theorem: Determinacy of one-step evaluation

**Problem**. If $t \to t'$ and $t \to t''$, then $t' = t''$.

<details>

<summary>Proof</summary>


- Induction on a **derivation of $t \to t'$**.
- At *each step of the induction*, **assume the desired result for all smaller derivations**.
- Proceed by a case analysis of the evaluation rule used at the root of the derivation.
- Consider the **last rule** used in **the derivation of $t \to t'$**.
1. `E-IfTrue`

\to $t$ has the form $\text{if } t_1\text{ then }t_2\text{ else }t_3$, where $t_1 =\text{true}$.

\to The last rule in the derivation of $t \to t''$ cannot be `E-IfFalse` since we cannot have both $t_1 = \text{true}$ and $t_1 = \text{false}$.

\to The last rule in the second derivation cannot be `E-If` either, since the premise of this rule demands that $t_1 \to t'_1$ for some $t'_1$, but $\text{true}$ does not evaluate to anything.

\to The last rule in the second derivation can only be `E-IfTrue`, and it immediately follows that $t' = t''$.

2. `E-IfFalse`
3. `E-If`

\to $t$ has the form $\text{if }t_1\text{ then }t_2\text{ else }t_3$, where $t_1 \to t'_1$ for some $t'$.

Symmetrically, the last rule in the derivation of $t \to t''$ can only be `E-If`, which tells us that $t$ has the form $\text{if }t_1\text{ then }t_2\text{ else }t_3$ (which we already know) and that $t_1 \to t''_1$ for some $t''_1$.

\to Now the induction hypothesis applies.
:::tip
This **should** hold for most systems.
:::

</details>

### Exercise 3.5.5

**Problem**. Spell out the induction principle used in the preceding proof, in the style of Theorem 3.3.4.

<details>

<summary>Solution</summary>



For a derivation $D$, take $| D |$ to be the largest length from the root to a leaf in the derivation.

***Induction on derivation:***

If, for each derivation $D$, given $P(D')$ for all $D'$ such that $| D' | < | D |$, we can show  $P(D)$, then $P(D)$ holds for all $D$.
</details>

## Normal form

- The final value of computation is particularly interested - **states in which the machine cannot take a step**.
- A term $t$ is in **normal form** if **no evaluation rule applies to it**- i.e., if there is no $t'$ such that $t \to t'$.
    
    (We sometimes say "$t$ is a normal form" as shorthand for "$t$ is a term in normal form.")
    

### Theorem: Value is in normal form

**Statement**. Every value is in normal form.

- Trivial theorem for the current system.
- In most systems, this theorem should hold - otherwise, the language is simply broken.
- Being in normal form is part of what it is to be a value (i.e., a fully evaluated result).
:::tip
This **should** hold for most systems.
:::

### Theorem: Normal form implies value

**Statement**. If $t$ is in normal form, then $t$ is a value.

<details>

<summary>Proof</summary>


Suppose $t$ is not a value.

We show by structural induction that $t$ is not in normal form.

Because $t$ is not a value, $t$ must have the form $\text{if }t_1\text{ then }t_2\text{ else } t_3$ for some $t_1$, $t_2$, $t_3$.

- If $t_1 = \text{true}$ or $t_1 = \text{false}$, it's obvious that $t$ is not in normal form because we can use `E-IfTrue` or `E-IfFalse`.
- If $t_1$ is neither $\text{true}$ nor $\text{false}$, then it is not a value.

\to The induction hypothesis applies, $t_1$ is not a normal form. Then $t$ is not in normal form because we can use `E-If`.
:::warning
This **does not** hold for most systems.
:::

</details>

## Multi-step evaluation relation

- The **multi-step evaluation relation** $\to^*$ is the **reflexive**, **transitive closure** of **one-step evaluation**.

### Exercise 3.5.10

**Problem**. Rephrase Definition 3.5.9 as a set of inference rules.

<details>

<summary>Solution</summary>



This one uses the inductive definition style instead of inference rules format because they are similar and inductive definition can be written more easily in Notion.

$\to^*$ is the smallest set such that:

- For every term $t$, $t \to^* t$.
- For every term $t$, $t'$, if $t \to t'$ then $t \to^* t'$.
- For every term $t$, $t'$, $t''$, if $t \to^* t'$ and $t' \to^*t''$ then $t \to^* t''$.



</details>

### Theorem: The uniqueness of normal form

**Statement**. If $t \to^* u$ and $t \to^* u'$, where $u$ and $u'$ are both normal forms, then $u = u'$.

<details>

<summary>Proof</summary>


Follow directly from determinacy of single-step evaluation relation.
:::tip
This **should** hold for most systems.
:::

</details>

### Theorem: Termination of evaluation

**Statement**. For every term $t$ there is some normal form $t'$ such that $t \to^* t'$.

<details>

<summary>Proof</summary>


- Each **evaluation step** *reduces* **the size of the term**.
- The size is a **termination measure** because **the usual order on the natural numbers** is **well founded**.
:::warning
This **does not** hold for most systems.
:::

</details>

### Exercise 3.5.13

**Statement 1**. Suppose we add a new rule:

to the ones in Figure 3-1. Which of the above theorems (3.5.4, 3.5.7, 3.5.8, 3.5.11, and 3.5.12) remain valid?

<details>

<summary>Solution</summary>



</details>

    - Theorem - Determinacy of one-step evaluation
        
        [x] No longer valid.
        
        Counterexample:
        
        $t = \text{ if }\text{true }\text{then }\text{true }\text{else }\text{false}$ 
        
        - Applying `E-Funny1`, $t \to \text{ false}$.
        - Applying `E-IfTrue`, $t \to \text{ true}$.
    - Theorem - Value is in normal form
        
        Still valid.
        
    - Theorem - Normal form implies value
        
        Still valid.
        
    - Theorem - The uniqueness of normal forms
        
        [x] No longer valid.
        
        Counterexample: Same as Determinacy of one-step evaluation
        
    - Theorem - Termination of evaluation
        
        Still valid.
        



**Statement 2**. Suppose instead that we add this rule:

Now which of the above theorems remain valid? Do any of the proofs need to change?

<details>

<summary>Solution</summary>



</details>

    - Theorem - Determinacy of one-step evaluation
        
        Still valid.
        
        This proof should change.
        
    - Theorem - Value is in normal form
        
        Still valid.
        
        This proof doesn't need to change.
        
    - Theorem - Normal form implies value
        
        Still valid.
        
        The proof doesn't need to change.
        
    - Theorem - The uniqueness of normal forms
        
        Still valid.
        
        This proof should change.
        
    - Theorem - Termination of evaluation
        
        Still valid.
        
        This proof should change (a bit).
        



# Evaluation - Arithmetic expressions

Operational semantics of arithmetic expressions - An extension of boolean expressions above

- A *new* **syntactic category** of **numeric values**.
    
    The **final result** of **evaluating an arithmetic expression** can be a number, where a number is either $0$ or the successor of a number. (but not the successor of an arbitrary value: we will want to say that $\text{succ}(\text{true})$ is an error, not a value).
    
- Note that in `E-PredSucc`, only numeric values are allowed.
    
    \to $\text{pred }(\text{succ } (\text{pred } 0)) \not\to \text{pred } 0$.
    
    \to This is prohibited to preserve the determinacy of one-step evaluation.
    
    The unique next step.
    

### Exercise 3.5.14 - Determinacy of one-step evaluation

**Statement**. Show that Theorem 3.5.4 is also valid for the evaluation relation on **arithmetic expressions**: if $t \to t'$ and $t \to t''$, then $t' = t''$.

<details>

<summary>Proof</summary>


This only considers the subset of arithmetic expressions.

Perform induction on a specific derivation $t \to t'$.

Assume that this holds for all smaller derivations.

- Consider the last rule applied to obtain $t \to t'$.
- `E-Succ`

In this case, $t = \text{succ }t_1$ and $t' = \text{succ }t'_1$ such that $t_1 \to t_1'$.

Then, $t \to t''$ must also be obtained from `E-Succ` as well, because there's no other rules that allow $t$ to be in the form of $\text{succ }t_1$.

Therefore, $t'' = \text{succ }t''_1$ such that $t_1 \to t_1''$.

By induction hypothesis, it holds true for this case.

- `E-PredZero`

In this case, $t = \text{pred }0$ and $t' = 0$.

So, the potential rules that can generate $t \to t''$ are `E-PredZero`, `E-PredSucc` or `E-Pred`.

`E-PredSucc` cannot generate $t \to t''$ because then, $t$ must be in the form of $\text{pred } (\text{succ }nv_1)$.

`E-Pred` cannot generate $t \to t''$ because $0$ is a normal form.

`E-PredZero` is trivial.

- `E-PredSucc`
- `E-Pred`
- `E-IsZeroZero`
- `E-IsZeroSucc`
- `E-IsZero`

</details>

## Stuck terms

- A **closed term** is **stuck** if it is in **normal form** but **not a value**.
    
    \to "Stuckness" represents a simple notion of **run-time error** for our simple machine.
    
    \to Stuckness characterizes the situations where **the operational semantics does not know what to do** because **the program has reached a "meaning-less state."**
    
    \to In a more concrete implementation of the language, these states might correspond to **machine failures** of various kinds: segmentation faults, execution of illegal instructions, etc.
    
    \to All these kinds of bad behavior are collapsed into the single concept of **"stuck state."**
    

### Exercise 3.5.16 - Explicit failure state in operational semantics

**Statement**.

A **different way** of **formalizing meaningless states** of **the abstract machine** is to:

1. Introduce **a new term** called $\text{wrong}$.
2. **Augment the operational semantics** with **rules** that **explicitly generate** $\text{wrong}$ in all the situations where **the present semantics gets stuck**.

To do this in detail, we introduce **2 new syntactic categories**:

and we **augment the evaluation relation** with **the following rules**:

Show that these **2 treatments** of **run-time errors** agree by:

1. Finding **a precise way** of **stating the intuition** that "**the two treatments agree**,"
2. Proving it.

As is often the case when proving things about programming languages, the tricky part here is formulating a precise statement to be proved - the proof itself should be straightforward.

 Observation:

- `badnat` contains `wrong` and normal booleans.
- `badbool` contains `wrong` and `nv`.
- So, a term can fall within **multiple syntactic categories**.
<details>
<summary>Solution</summary>



1. Call the original operational semantics $\mathcal{O_1}$.

Call the original operational semantics $\mathcal{O}_2$.

For conciseness, we skip the proofs for the determinacy of the single-step evaluation for $\mathcal{O_1}$ and $\mathcal{O}_2$.

We treat each operational semantic as a partial function from terms to terms such that:

- If there exists a normal form term $n$ such that $t \to^* n$ then $\mathcal{O}(t) = n$.
- Otherwise, $\mathcal{O}(t)\uparrow$.

Then, $\mathcal{O}_1$ is equivalent to $\mathcal{O}_2$ iff:

- $\mathcal{O_1}\uparrow \iff \mathcal{O_2}\uparrow$.
- For each term $t$ that is syntactically valid in $\mathcal{O}_1$, if $n$ is a value, then $\mathcal{O_1}(t) = n \iff \mathcal{O}_2(t) = n$.
- For each term $t$ that is valid in $\mathcal{O}_1$, $\mathcal{O}_1(t)$ stucks $\iff \mathcal{O}_2(t) = \text{wrong}$.
2. It's pretty trivial that evaluations in $\mathcal{O}_1$ and $\mathcal{O}_2$ always terminate.

Because $\mathcal{O}_2$ is a superset of $\mathcal{O}_1$ and both are deterministic, if $\mathcal{O}_1(t)$ yields a value, $\mathcal{O}_2$ must also yield a value.

If $\mathcal{O}_1$ stucks then $\mathcal{O_1} = n$ such that $n$ is a normal form but not a value.

Then, because $\mathcal{O}_2$ is a superset of $\mathcal{O}_1$ and both are deterministic, $\mathcal{O_2}(t) = \mathcal{O_2}(n)$.

We consider the possible forms of a stuck term in $\mathcal{O}_1$.

- $n = \text{if } t_1 \text{ then } t_2\text{ else } t_3$.

Then, $t_1$ must be $\text{badbool}$.

Then, $\mathcal{O}_2(n) = \text{wrong}$.

- $n = \text{pred }t_1$ .

Then, $t$ itself must be stuck in $\mathcal{O}_1$.

Then, by the induction hypothesis, $\mathcal{O}_2(t_1) = \text{wrong}$.

Then, applying rule `E-Pred`, we have $\mathcal{O}_2(n) = \text{pred } \text{wrong} = \text{wrong}$.

- $n = \text{succ }t$ .

Similar to the above case.

- $n = \text{isZero }t$ .

Similar to the above case.
</details>

### Exercise 3.5.17

**Statement**. **Two styles of operational semantics** are in common use.

- The one used in this book is called **the small-step style**, because **the definition of the evaluation relation** shows how **individual steps of computation** are used to **rewrite a term, bit by bit, until it eventually becomes a value**.
    
    On top of this, we define a **multi-step evaluation relation** that allows us to talk about terms evaluating (in many steps) to values.
    
- An alternative style, called **big-step semantics** (or sometimes **natural semantics**), directly formulates the notion of **"this term evaluates to that final value**," written $t \Downarrow v$. The **big-step evaluation rules** for our language of boolean and arithmetic expressions look like this:

Show that the small-step and big-step semantics for this language coincide, i.e. $t \to^* v$ iff $t \Downarrow v$.

 Observation: The right-hand-side for the $\Downarrow$ is always a normal form.

<details>

<summary>Proof</summary>


</details>

### Exercise 3.5.18

**Statement**. Suppose we want to change **the evaluation strategy** of our language so that **the $\text{then}$ and $\text{else}$ branches of an $\text{if}$ expression are evaluated** (in that order) **before the guard is evaluated**. Show how the evaluation rules need to change to achieve this effect.

<details>

<summary>Solution</summary>



- Remove `E-If`.
- Add rule `E-IfThen`:

$$
\displaystyle\frac{t_2 \to t'_2}{\text{if }t_1\text{ then }t_2\text{ else }t_3 \to \text{if }t_1\text{ then }t'_2\text{ else }t_3}
$$

- Add rule `E-IfElse`:

$$
\displaystyle\frac{t_3 \to t'_3}{\text{if }t_1\text{ then }v_2\text{ else }t_3 \to \text{if }t_1\text{ then }v_2\text{ else }t'_3}
$$

- Add rule `E-IfCond`:

$$
\displaystyle\frac{t_1 \to t'_1}{\text{if }t_1\text{ then }v_2\text{ else }v_3 \to \text{if }t'_1\text{ then }v_2\text{ else }v_3}
$$
</details>

# Related resources

- Abstract and concrete syntax, parsing: Dozens of textbooks on compilers.
- Inductive definitions, systems of inference rules, and proofs by induction: [Winskel, 1993; Hennessy, 1990].
- The style of operational semantics that we are using here: A technical report by [Plotkin, 1981].
- The big-step style (Exercise 3.5.17): [Kahn, 1987].
    
    See [Astesiano, 1991] and [Hennessy, 1990] for more detailed developments.
    
- Structural induction was introduced to computer science by [Burstall, 1969].

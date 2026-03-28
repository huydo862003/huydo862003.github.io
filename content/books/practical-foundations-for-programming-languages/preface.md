---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Preface
author: Robert Harper
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts: []
parent: practical-foundations-for-programming-languages
children: []
---

**About**: Type systems + Programming languages (from type-theoretic view).

- Software engineering.
- Language design - High-performance compiler implementation.
- Security.

→ Fundamental definitions + results + techniques.

---

**For**: 2 main audiences.

- Graduate students: Tour to proceed to the research literature.
- Researchers in programming languages and type theory: Extensive introductory material.

---

**Aims**:

- Coverage of core topics:
    - Operational semantics
    - Proof techniques
    - Untyped lambda-calculus - Simple type systems
    - Universal and existential polymorphism
    - Type reconstruction
    - Subtyping
    - Bounded quantification
    - Recursive types
    - Type operators
    - Other topics
- Pragmatism:
    - The use of type systems in programming languages.
    - (Not included) Denotational semantics.
- Respect for diversity: Only several well-understood combinations of language features are covered.
    
    > For example, many varieties of "arrow types" can be elegantly and compactly treated in the uniform notation of pure type systems.
    > 
    - What are arrow types?
        - A function type.
        - **Curried:** A function of two arguments $A \times B \to C$ is often seen as $A \to (B \to C)$.
        - **The core of STLC:** In the simply-typed λ-calculus, $A \to B$ is the main way of building new types from old ones.
        - **Special cases of more general function types:** In fancier systems, you get:
            - Dependent arrows ($\Pi$-types): $\Pix:A. B(x)$.
            - Linear arrows $A\multimapB$.
            - Effectful arrows $A \to_{\mathsf{IO}} B$.
            - Etc.
        - In most advanced systems, the usual arrow $A\toB$ is just *syntax sugar* for a non-dependent Π-type: $A \to B \equiv \Pi x: A. B$(when x doesn't appear in B).
    - What are pure type systems?
        
        A *pure type system* is a very general, minimalist framework in which many well-known typed λ-calculi (STLC, System F, System Fω, Calculus of Constructions, etc.) can be described by just changing a small specification.
        
        Idea:
        
        - Everything is built from:
            1. **λ-abstraction / application** (terms as functions)
            2. **Π-types** (dependent function types)
        
        No built-in `→`, `∀`, `λ`-kinds, etc. All of those get encoded via Π and the choice of "sorts" and "rules."
        
        A PTS is specified by three ingredients:
        
        1. **A set of sorts** $\mathcal{S}$.
            
            Examples you might see:
            
            - (or `Type`) - the sort of "ordinary types".
            - `□` (or `Kind`) - the sort of "kinds" that classify type constructors.
        2. **Axioms** $\mathcal{A} \subseteq \mathcal{S} \times \mathcal{S}$.
            
            These say which sorts classify which. Example:
            
            - $(*, \square)$ could mean: $*$ is itself an inhabitant of  $\square$, i.e. $*:  \square$.
        3. **Rules** $\mathcal{R} \subseteq \mathcal{S} \times \mathcal{S} \times \mathcal{S}$.
            
            Each triple $(s_1, s_2, s_3)$ says: If $A$ has sort $s_1$ and $B$ (possibly depending on a variable of type $A$) has sort $s_2$, then the $\Pi$-type $\Pi x:A.\,B$ has $s_3$.
            
            This is the *only* **type-former**: once you say which sort-triples are allowed, you've determined what kinds of function types/polymorphism / higher kinds you get.
            
        
        Because of this, many systems become just *instances* of PTS:
        
        - **STLC**: Can be seen as a PTS with only non-dependent Π-types between types in $*$  (so $\Pi$ degenerates to $\to$).
        - **System F**: A PTS where you allow $\Pi$ over types as well, giving polymorphism (`∀α. A` is a $\Pi$).
        - **System Fω**: same, plus higher-kinded polymorphism.
        - **CoC (Calculus of Constructions)**: a very expressive PTS where terms, types, and propositions are all in one uniform framework.
        
        "Pure" here means:
        
        - No extra primitive connectives (no built-in `×`, `+`, `Bool`, `Nat`, etc.).
        - Just λ-terms and Π-types; everything else is encoded.
- Ease of use.
- Honesty: Accompanied typecheckers and interpreters.

**Non-aims**:

- Completeness of coverage.
- Efficiency: Not a book on industrial-strength compiler or typechecker implementation.

---

**Computational foundation**: Call-by-value lambda calculus:

- Match most present-day languages.
- Extend easily to imperative constructs (references and exceptions).

---

**Considerations for each language feature**:

- Motivations for the feature.
- Techniques to prove safety of languages that include it.
- Implementation issues: Design and analysis of typechecking algorithms.

---

**Some of the author's suggested books**:

- "Essentials of programming languages" by Friedman, Wand, and Haynes (2001).
- "Programming Language Pragmatics" by Scott (1999).

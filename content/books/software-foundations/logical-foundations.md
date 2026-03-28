---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Logical Foundations
author: Benjamin C. Pierce et al.
date: "2010"
journey: plt
tags:
  - PLT
  - textbook
concepts:
  - proof-assistant-prover
  - automated-theorem-prover-sat-solver-smt-solver
  - rocq-tactic
  - rocq-dependent-type
  - functional-programming
parent: "software-foundations"
children:
  - chapter-1-basics-functional-programming-in-rocq
  - chapter-2-inductive-definitions
  - chapter-3-hypothetical-and-general-judgments
---


This book lays groundwork for the others in the Software Foundations series.

- Functional programming.
- Intuitionistic/Constructive logic.
- The Rocq prover.

# Overview

3 conceptual threads:

- Basic tools from *logic* for making and justifying precise claims about programs.
- The use of *proof assistants* (or *provers*) to construct rigorous logical arguments.
- *Functional programming*, both as a method of programming that simplifies reasoning about programs and as a bridge between programming and logic.

# Logic

- Logic: The field of study whose subject matter is Proof.
- Proof: Unassailable arguments for the truth of particular propositions.
- Logic plays the central role in computer science.
    - Manna and Waldinger: "The calculus of computer science".
    - Halpern et al.'s paper "On the *Unusual Effectiveness of Logic in Computer Science*": Logic offers critical tools and insights.
        
        "As a matter of fact, logic has turned out to be significantly more effective in computer science than it has been in mathematics. This is quite remarkable, especially since much of the impetus for the development of logic during the past one hundred years came from mathematics." 
        
    - The fundamental tools of *inductive proof* are ubiquitous in all of computer science.

# Proof assistants

- Logic ↔ Computer science.
- Computer science → Logic: The development of software tools for helping construct proofs of logical propositions.
    
    Two broad categories:
    
    - Automated theorem prover: Provide "push-button" operation - Give it a proposition and they return either true or false or "don't know: ran out of time".
        - Pros: Largely automated.
        - Cons: Limited reasoning capabilities.
        - Matured tremendously: SAT solvers, SMT solvers, Model checkers.
    - Proof assistant/Prover: Hybrid semi-automated tools that automate the more routine aspects of building proofs while depending on human guidance for more difficult aspects.
        
        Isabelle, Agda, Twelf, ACL2, PVS, F*, HOL4, Lean, and Rocq.
        
- We focus on [Rocq (formerly Coq)](/journeys/plt/concepts/rocq).
    - Under development since 1983.
    - Popular research and industry wise.
- [Rocq (formerly Coq)](/journeys/plt/concepts/rocq): Provide rich environment for interactive development of machine-checked formal reasoning.
    
    Inside a Rocq system:
    
    - The kernel: A simple proof-checker. → Guarantees that only correct deduction steps are ever performed.
    - On top of the kernel: High-level facilities for proof development.
        - A large library of common definitions and lemmas.
        - Powerful tactics for constructing complex proofs semi-automatically.
        - A special-purpose programming language for defining new proof-automation tactics for specific situations.
- Rocq has been a critical enabler for a huge variety of work across computer science and mathematics:
    - As a **platform for modeling programming languages**, Rocq is a standard tool for researchers who need to describe and reason about complex language definitions.
        - Security checker of the JavaCard platform.
        - Formal specifications of the x86 and LLVM instruction sets.
        - Formal specifications of programming languages such as C.
    - As an **environment for developing formally certified software and hardware**:
        - CompCert: A fully-verified optimizing compiler for C.
        - CertiKOS: A fully verified hypervisor, for proving the correctness of subtle algorithms involving floating point numbers.
        - CertiCrypt, FCF, and SSProve, which are frameworks for proving cryptographic algorithms secure.
        - Verified implementations of the open-source RISC-V processor architecture.
    - As a **realistic environment for functional programming with dependent types**: Inspire numerous innovations.
        
        Hoare Type Theory (an extension of Hoare Logic) embeds reasoning about "pre-conditions" and "post-conditions" in Rocq.
        
    - As a **proof assistant for higher-order logic**: Validate a number of important results in mathematics.
        - First formally verified proof of the 4-color theorem.
        - Rocq formalization of the Feit-Thompson theorem.

# Functional programming

- Functional programming:
    - A collection of programming idioms that can be used in almost any programming language.
    - A family of programming languages designed to emphasize these idioms: Haskell, OCaml, Standard ML, F#, Scala, Scheme, Racket, Common Lisp, Clojure, Erlang, F*, Rocq.
- Roots: Church's lambda-calculus.
- Since the early '90s, it has enjoyed a surge of interest among industrial engineers and language designers.

- Most basic principle: ***As much as possible***, **computation should be pure**. - The only effect of execution should be to produce a result, free from Side-effects.
    
    → Point 1: Programs become easier to understand and reason about.
    
    → No need to worry about shared data structure mutations cause unintended breaks.
    
    → Point 2: Especially interested in concurrent programming.
    
    → Easier to parallelize and physically distribute than their imperative counterparts.
    
    → Data structure can be copied freely.
    
    → The Map-Reduce idiom.
    
    → Point 3: A bridge between logic and computer science.
    
    → [Rocq (formerly Coq)](/journeys/plt/concepts/rocq) is a combination of:
    
    - A small but extremely expressive functional programming language.
    - A set of tools for stating and proving logical assertions.
        
        → The two sides of Rocq are actually aspects of the same underlying machinery: **Proofs are programs**.
        

# Rocq vs Coq

- Until 2024, the Rocq prover was known as Coq.
    - "Coq" = Calculus of Constructions (CoC), the foundational system it is based on + Thierry Coquand + French national symbol (rooster).
    - Rocq = Inria Rocquencourt, where the prover was developed + mythological bird Roc + A sense of solidity + Connection to music.

---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Programming languages: Application and Interpretation"
author: Shriram Krishnamurthi
date: "2012"
journey: plt
tags:
  - PLT
  - textbook
concepts: []
parent: ""
children:
  - chapter-1-learning-smol-standard-model-of-languages
  - chapter-2-evaluation
  - chapter-3-syntactic-sugar
  - chapter-4-objects
  - chapter-5-types
---


- Why study programming languages?
    
    > Force precise thinking. Prove what code can and can't express. Understand why companies create languages for competitive edge.
    > 
- Core learning framework
    - SMoL - Standard Model of Languages
        
        The shared DNA of Java, Python, JavaScript, Ruby, etc:
        
        | Feature | What it means |
        | --- | --- |
        | Automatic memory | No manual allocation |
        | Eager evaluation | Compute arguments first |
        | First-class functions | Pass functions like data |
        | Mutable state | Variables can change |
        
        **Key insight:** Think in *features*, not paradigms (OOP vs functional is outdated).
        
    - SImPl - Standard Implementation Plan
        
        `Parse → Syntax tree → Recursive processing`
        
        Same pattern powers interpreters, compilers, and type-checkers.
        
    - Mystery languages
        
        Same syntax, different behaviors → learn by contrasting how features vary.
        
- Tools
    
    
    | Tool | Purpose |
    | --- | --- |
    | **SMoL tutor** | Automated practice |
    | **Stacker** | Visualize program execution |
    | **Racket #lang** | Build custom languages |

Resources: `cs.brown.edu/courses/csci1730/`

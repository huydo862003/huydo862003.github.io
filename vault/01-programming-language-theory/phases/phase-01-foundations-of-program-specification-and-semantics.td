---
_type: PltPhase
_label: 'Phase 1 - foundations of program specification and semantics'
journey: fref("/01-programming-language-theory/index.td")
status: 'active'
_ssg:
  show_in_sidebar: false
---

The mathematical bedrock of everything else.

## Concepts

- Lambda calculus (untyped, simply typed, System F, Fomega, calculus of constructions)
- Operational semantics (small-step, big-step, reduction semantics, structural vs natural)
- Denotational semantics (domain theory, game semantics, categorical models)
- Axiomatic semantics & program logics (Hoare logic, separation logic, Iris)
- Logical relations & parametricity
- Metatheory: progress, preservation, normalization, logical consistency

## Dependency

Lambda calculus + OpSem + basic Meta -> (DenoSem + Axiomatic + Logical relations)

## Resources

- **TAPL** - untyped -> STLC -> System F, System Fomega (type theory progression)
- **PFPL** - foundational theory; excellent for lambda calculus, semantics, and type systems
- **PLAI** - practical lambda-calculus in interpreters
- **SF (PLF)** - STLC in Coq; Coq mechanization of progress/preservation
- Gunter *Semantics of Programming Languages* - deeper denotational semantics
- Nielson & Nielson *Semantics with Applications* - axiomatic semantics intro
- Harper blog posts + HN comments - lambda-calculus mindset

## Papers

- On the Criteria To Be Used in Decomposing Systems into Modules
- Extended Static Checking
- Inferring Type Rules for Syntactic Sugar

## Projects

- typerighter

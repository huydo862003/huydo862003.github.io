---
_type: PltPhase
_label: 'Phase 4 - type systems & static verification'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 4
_ssg:
  show_in_sidebar: false
---

The heart of modern PL research. Sits directly on top of phases 1 and 3.

## Concepts

- Simply-typed lambda calculus & Hindley-Milner type inference
- Polymorphism (parametric, ad-hoc, row, bounded, higher-rank, impredicative)
- Subtyping & substructural typing (linear, affine, ordered, session types)
- Dependent types (Luo's UTT, Martin-Lof, Calculus of Inductive Constructions)
- Refinement types & liquid types
- Gradual typing & migratory typing
- Effect systems & effect handlers (algebraic effects, Koka-style)
- Ownership & region types (Rust, Cyclone)
- Theorem proving interfaces (Coq, Lean, Agda, Idris, F\*)

## Dependency

Foundations + Computability -> Core type systems -> (subtyping, linear, effects, refinements, dependently-typed proving)

## Resources

- **TAPL** - STLC + HM, System F, bounded polymorphism, subtyping
- **PFPL** - systematic view; linear types, substructural systems
- **SF (PLF)** - soundness proofs; Coq mechanization
- Papers: "linear types", "session types" survey via SIGPLAN
- Liquid Haskell / F\* tutorials - refinement types in practice
- Siek blog + classic gradual typing papers (SIGPLAN) - gradual typing
- Rust and Cyclone research papers; PLP (memory management & regions) - ownership
- SF (Coq), CPDT; Lean/Agda/F\* official tutorials - theorem proving interfaces

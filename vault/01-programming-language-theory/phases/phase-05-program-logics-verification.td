---
_type: PltPhase
_label: 'Phase 5 - program logics & verification'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 5
_ssg:
  show_in_sidebar: false
---

Proving programs correct. This builds on type systems and axiomatic semantics.

## Concepts

- Hoare logic & separation logic
- Higher-order separation logic & Iris framework
- Dependent type verification (Coq, Agda, F\*)
- SMT-based verification (Dafny, Liquid Haskell, F\*, Why3)
- Model checking for programming languages features

## Dependency

Axiomatic semantics + Type systems -> Program logics -> Heavy-duty verification

## Resources

- **SF** (Hoare logic chapters) - main resource; Nielson & Nielson supplement
- Reynolds / O'Hearn survey papers - separation logic foundations
- Iris tutorial papers & Coq libraries (via SIGPLAN / project page) - higher-order separation logic
- Coq (SF, CPDT); F\* tutorials; Agda/Idris resources - dependent type verification
- Tool-specific docs + Liquid Haskell papers; F\* papers (via SIGPLAN) - SMT-based verification
- Dafny / Why3 tutorials - practical Hoare-style verification
- Books / papers on model checking (CTL/LTL) adapted to PL constructs (via SIGPLAN / CAV)

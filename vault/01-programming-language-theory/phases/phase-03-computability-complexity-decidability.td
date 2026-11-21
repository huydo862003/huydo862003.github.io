---
_type: PltPhase
_label: 'Phase 3 - computability, complexity & decidability'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 3
_ssg:
  show_in_sidebar: false
---

What can and cannot be decided about programs. This grows out of lambda calculus and basic logic.

## Concepts

- Type checking/inference decidability (System F vs. Fomega, dependent types)
- Termination checking (size-change principle, typed termination)
- Rice's theorem & undecidable properties
- Complexity of type inference (ML vs. Haskell 98 vs. GHC extensions)

## Dependency

Lambda calculus + OpSem -> Computability/undecidability -> Decidability/complexity of typing

## Resources

- Sipser *Theory of Computation* - Rice's theorem, halting problem, decidability background
- **TAPL** - decidability remarks for each type system
- **PFPL** - more formal treatment
- Agda / Coq / F\* tutorials on total languages & termination
- Papers: termination checking (POPL/ICFP) via ACM DL
- HN/Reddit threads + survey/tutorial papers found via SIGPLAN (for GHC-specific complexity / extensions)

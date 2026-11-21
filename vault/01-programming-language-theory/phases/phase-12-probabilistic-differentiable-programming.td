---
_type: PltPhase
_label: 'Phase 12 - probabilistic & differentiable programming'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 12
_ssg:
  show_in_sidebar: false
---

Modern frontier. Very semantic / type-theoretic.

## Concepts

- Probabilistic programming languages (Stan, Pyro, Gen)
- Measure-theoretic semantics
- Automatic differentiation (forward-mode, reverse-mode, source transformation vs. operator overloading)

## Dependency

Denotational semantics + Types -> Probabilistic/diff semantics -> AD-based PLs

## Resources

- Stan/Pyro/Gen language docs; PPL survey papers via SIGPLAN & ML venues - probabilistic languages
- PPL semantics tutorial notes (e.g. Staton, Sato) and **PFPL** background on semantics - measure-theoretic semantics
- AD survey papers; implementation notes for JAX / Stan / PyTorch; **PLP** optimization/IR sections - automatic differentiation

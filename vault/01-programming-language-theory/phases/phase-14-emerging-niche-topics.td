---
_type: PltPhase
_label: 'Phase 14 - emerging & niche topics (2024-2025)'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 14
_ssg:
  show_in_sidebar: false
---

Worth keeping on the radar. These are "leaves" that depend on earlier phases.

## Concepts

- Effect handlers in mainstream languages (Koka, Unison, OCaml 5) - from effect systems & implementation
- Linear types in Rust & Haskell - from substructural type systems
- Memory-safe systems programming (Rust, Verona, Midori heritage) - from types, ownership, runtime
- WebAssembly as a compilation target & GC extensions - from IR, codegen, runtimes
- Formal foundations of blockchain/smart-contract languages (Move, Michelson, Scilla) - from security, program logics, types
- Quantum programming languages (Q#, Silq, Scaffold) - from new kinds of type systems and semantics

## Dependency

Types + Semantics + Implementation + Security -> These emerging designs

## Resources

- Algebraic effects/effect handlers papers (Eff, Koka, Multicore OCaml) via SIGPLAN; **PFPL** for theoretical effects background
- Rust & linear Haskell papers; **PFPL** for linear type theory; HN/Reddit threads for practice-oriented discussion
- Rust/Verona/Midori papers; Galois blog / SIGPLAN talks on memory-safe systems languages
- WebAssembly spec & GC proposal docs; PLDI/POPL papers on Wasm as IR
- Papers on Plutus, Tezos/Michelson, Move, etc. via SIGPLAN/IEEE security venues; Galois / industry blogs
- Q# docs; quantum lambda-calculus & quantum-type-system papers via POPL/LICS

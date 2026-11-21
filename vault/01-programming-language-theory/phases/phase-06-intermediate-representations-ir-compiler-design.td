---
_type: PltPhase
_label: 'Phase 6 - intermediate representations (IR) & compiler design'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 6
_ssg:
  show_in_sidebar: false
---

The bridge between high-level languages and machine code. Rests on operational semantics, lambda calculus, and parsing.

## Concepts

- Three-address code, SSA form, CPS, A-normal form, monadic form
- Functional IRs (LLVM, MLIR, GHC Core, GraalVM Truffle)
- Sea of Nodes & other graph-based IRs
- Polyglot & multi-tier IRs (MLIR dialects)

## Dependency

OpSem + Lambda + Parsing -> IR design -> Polyglot / graph-based IRs

## Resources

- **PLP** (IR chapters), **Dragon** (IR); SSA from LLVM docs - three-address code, SSA, CPS, ANF
- **PFPL** - CPS, monadic embeddings (advanced)
- LLVM LangRef; MLIR docs; GHC Core docs; Graal/Truffle papers - functional IRs
- Papers / blog posts on Sea-of-Nodes (HotSpot, V8) via SIGPLAN & engineering blogs
- MLIR docs & papers; SIGPLAN conference talks / papers - polyglot IRs

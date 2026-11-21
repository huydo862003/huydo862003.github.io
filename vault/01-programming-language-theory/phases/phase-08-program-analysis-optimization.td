---
_type: PltPhase
_label: 'Phase 8 - program analysis & optimization'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 8
_ssg:
  show_in_sidebar: false
---

Making code fast and small. Builds on IRs, operational semantics, and type systems.

## Concepts

- Data-flow analysis (liveness, reaching definitions, available expressions)
- Control-flow analysis & abstract interpretation
- Partial evaluation & supercompilation (Futamura projections)
- Loop optimizations (vectorization, invariant code motion, tiling)
- Inlining, specialization, & polyvariant flow analysis
- Garbage collection algorithms (mark-sweep, generational, concurrent, region)

## Dependency

IR + OpSem + Types -> Static analyses -> Optimizations

## Resources

- Nielson / Nielson / Hankin *Principles of Program Analysis*; Muchnick; **Dragon** - data-flow analysis
- LLVM pass tutorials - data-flow analysis in practice
- Nielson / Nielson / Hankin; Cousot survey papers on Abstract Interpretation - control-flow analysis
- Classic PE / supercompilation papers via SIGPLAN; **PLP** - partial evaluation overview
- Muchnick; **Dragon**; LLVM/MLIR docs on loop passes - loop optimizations
- Program analysis book (Nielson et al.); **PLP** optimization chapters; JIT compiler papers - inlining
- GC book (Jones & Lins), **PLP** runtime chapters; region-based work from PLDI/POPL

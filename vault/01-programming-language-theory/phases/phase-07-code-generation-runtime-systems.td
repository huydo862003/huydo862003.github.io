---
_type: PltPhase
_label: 'Phase 7 - code generation & runtime systems'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 7
_ssg:
  show_in_sidebar: false
---

From IR to bits. This builds very directly on IRs.

## Concepts

- Instruction selection (tree tiling, BURS, LLVM DAG matching)
- Register allocation (graph coloring, linear scan, extended linear scan)
- JIT vs. AOT compilation (GraalVM, HotSpot, V8 TurboFan)
- Runtime systems (garbage collectors, exception handling, coroutines, green threads)
- Tail-call optimization & proper tail recursion
- Foreign function interfaces & calling conventions

## Dependency

IRs -> Codegen -> JIT/AOT -> Runtime systems

## Resources

- **Dragon** & Muchnick *Advanced Compiler Design*; LLVM codegen docs - instruction selection
- Muchnick; **Dragon**; LLVM/HotSpot/V8 papers - register allocation
- **PLP** runtime/JIT chapters; GraalVM/HotSpot/V8 whitepapers & engineering blogs; HN threads on JIT design
- **PLP** (runtime chapter), **Dragon**; GC book (Jones & Lins) - runtime systems
- GHC RTS docs / JVM/CLR docs / V8 docs - runtime systems in practice
- **PLP** & **PFPL** for semantics of calls; compiler books for implementation - tail-call optimization
- **PLP** (FFI / interop discussions); ABI / calling convention docs for real platforms

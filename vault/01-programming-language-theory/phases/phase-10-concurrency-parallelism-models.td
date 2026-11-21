---
_type: PltPhase
_label: 'Phase 10 - concurrency & parallelism models'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 10
_ssg:
  show_in_sidebar: false
---

How languages express and reason about parallelism. Needs operational semantics and usually some type theory/logics to reason about it.

## Concepts

- Threads & locks vs. message passing (CSP, pi-calculus, Go channels)
- Progress guarantees, correctness conditions (safety, liveness, linearizability)
- Actors (Erlang/Elixir, Akka)
- Software transactional memory
- Data parallelism & GPU languages (CUDA, SYCL, Futhark)
- Session types for communication protocols
- Futures, promises, async/await semantics

## Dependency

OpSem + Types + Program logics -> Concurrency calculi & guarantees -> Practical concurrency constructs

## Resources

- Concurrency textbooks (e.g. Andrews), CSP/pi-calculus tutorial papers; Go docs (practical) - threads & message passing
- Concurrency theory texts & verification papers; SF / Iris if you go full logics - progress guarantees
- Erlang/Elixir/Akka docs; actor model papers (SIGPLAN) - actors
- STM papers (Haskell STM, etc.) via PLDI/POPL; **PLP** concurrency sections
- CUDA/SYCL docs; Futhark papers & docs via SIGPLAN - data parallelism
- Session type survey/tutorial papers; **PFPL** background on types & processes
- **PLP** concurrency; language-specific docs (Rust/JS/.NET async); papers on async/await desugaring & semantics

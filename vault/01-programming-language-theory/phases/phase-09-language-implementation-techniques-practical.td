---
_type: PltPhase
_label: 'Phase 9 - language implementation techniques (practical)'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 9
_ssg:
  show_in_sidebar: false
---

The "how" behind the theory. The engineering layer atop phases 2, 6, 7, and 8.

## Concepts

- Interpreter design patterns (tree-walk, bytecode VM, JIT)
- Garbage collection in practice (Boehm, JikesRVM, V8, JSC)
- Writing a compiler frontend in OCaml/Haskell/Rust
- Bootstrapping & self-hosting
- Language workbenches & extensible compilers (Spoofax, Racket, Cedar)

## Dependency

Parsing + IR + Codegen + Analysis -> Real compilers/interpreters -> Workbenches

## Resources

- **PLAI** (interpreters); *Crafting Interpreters* if you add it - interpreter design
- **PLP** runtime/implementation chapters - context
- GC book; Boehm docs; papers/engineering blogs for JikesRVM, V8, JSC - GC in practice
- **PLP** + **Dragon** (front-end); **PLAI** (front-end concepts); language-specific docs for Menhir, GHC, Rust tooling - compiler frontend
- **PLP** & compiler books; blog posts & historical papers (e.g. early Lisp/C bootstrapping) via ACM DL / HN
- Racket docs (language-oriented programming, macros); Spoofax/other workbench papers (Onward!, GPCE) - language workbenches
- SIGPLAN for language workbench workshops

---
_type: PltPhase
_label: 'Phase 11 - metaprogramming & extensibility'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 11
_ssg:
  show_in_sidebar: false
---

Languages that modify themselves. Heavy on syntax and semantics, and uses implementation knowledge.

## Concepts

- Macros (Lisp, Rust procedural macros, Template Haskell, Terra)
- Staging & multi-stage programming (Terra, LMS, Fury)
- Reflection & reification
- Quotation & anti-quotation
- Language-oriented programming & DSL design

## Dependency

Syntax + Types + Implementation techniques -> Macros + Staging -> DSL / language-oriented design

## Resources

- Racket macro docs (syntax/parse, syntax-case); Rust macro book; Template Haskell docs; Terra papers - macros
- Papers on multi-stage programming (e.g. LMS, MetaOCaml) via SIGPLAN/GPCE - staging
- **PLP** language feature chapters; papers on reflective languages (e.g. Lisp, Smalltalk, Racket) - reflection
- Racket & Template Haskell docs; multi-stage programming papers - quotation
- **PLAI** + Racket docs (LOP), GPCE & Onward! papers; Galois blog for DSLs in industrial FM - DSL design

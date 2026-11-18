---
_type: PltConcept
_label: 'Church numeral'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'lambda calculus'
  - 'semantics'
---

Tools: Rocq (formerly Coq)

- (Semantics, Lambda calculus) Church's encoding of numbers used in ${fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")}.

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

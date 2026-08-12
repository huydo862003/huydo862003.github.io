---
_type: Concept
title: 'Church numeral'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

Tools: Rocq (formerly Coq)

- (Semantics, Lambda calculus) Church's encoding of numbers used in ${fref("journeys/programming-language-theory/concepts/pure-untyped-lambda-calculus.td")}.

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

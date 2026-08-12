---
_type: Concept
title: 'Church numeral (rocq)'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

Church's encoding of numbers used in ${fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")}.

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

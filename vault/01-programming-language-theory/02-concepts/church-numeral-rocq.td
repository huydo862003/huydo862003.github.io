---
_type: PltConcept
_label: 'Church numeral (rocq)'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
---

Church's encoding of numbers used in ${fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")}.

Encoding: $c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))$.

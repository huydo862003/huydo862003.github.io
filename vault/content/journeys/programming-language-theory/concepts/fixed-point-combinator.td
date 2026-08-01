---
_type: Concept
title: 'Fixed-point combinator'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

Tools: Rocq (formerly Coq)

- (${fref("journeys/programming-language-theory/concepts/lambda-calculus.td")}, Semantics) A ${fref("journeys/programming-language-theory/concepts/combinator.td")} that finds a fixed-point of a functional (a function that takes a function and returns another function). There are many such combinators, such as the ${fref("journeys/programming-language-theory/concepts/curry-y-combinator.td")} or the ${fref("journeys/programming-language-theory/concepts/z-combinator.td")}. Formally, a fixed-point combinator is a combinator $\text{fix}$ such that for any functional $g$, $\text{fix}\ g$ is beta/eta-equivalent to $g\ (\text{fix}\ g)$.

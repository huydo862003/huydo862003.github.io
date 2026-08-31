---
_type: PltConcept
_label: 'Fixed-point combinator'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

Tools: Rocq (formerly Coq)

- (${fref("programming-language-theory/concepts/lambda-calculus.td")}, Semantics) A ${fref("programming-language-theory/concepts/combinator.td")} that finds a fixed-point of a functional (a function that takes a function and returns another function). There are many such combinators, such as the ${fref("programming-language-theory/concepts/curry-y-combinator.td")} or the ${fref("programming-language-theory/concepts/z-combinator.td")}. Formally, a fixed-point combinator is a combinator $\text{fix}$ such that for any functional $g$, $\text{fix}\ g$ is beta/eta-equivalent to $g\ (\text{fix}\ g)$.

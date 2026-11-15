---
_type: PltConcept
_label: 'Fixed-point combinator'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (${fref("/01-programming-language-theory/02-concepts/lambda-calculus.td")}, Semantics) A ${fref("/01-programming-language-theory/02-concepts/combinator.td")} that finds a fixed-point of a functional (a function that takes a function and returns another function). There are many such combinators, such as the ${fref("/01-programming-language-theory/02-concepts/curry-y-combinator.td")} or the ${fref("/01-programming-language-theory/02-concepts/z-combinator.td")}. Formally, a fixed-point combinator is a combinator $\text{fix}$ such that for any functional $g$, $\text{fix}\ g$ is beta/eta-equivalent to $g\ (\text{fix}\ g)$.

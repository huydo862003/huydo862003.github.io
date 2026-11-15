---
_type: PltConcept
_label: 'Computation theory'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
tags:
  - 'computation theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The branch of theoretical computer science studying what can be computed and with what resources - includes models of computation (Turing machines, ${fref("/programming-language-theory/concepts/lambda-calculus.td")}), ${fref("/programming-language-theory/concepts/decidability.td")} (halting problem, Ric

The branch of theoretical computer science studying **what can be computed** and **with what resources** - includes models of computation (Turing machines, lambda calculus), decidability (halting problem, Rice's theorem), complexity classes (P, NP), and the Chomsky hierarchy of formal languages.

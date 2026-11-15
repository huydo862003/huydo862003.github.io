---
_type: PltConcept
_label: 'If-splitting'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'program analysis'
  - 'programming paradigm'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system mechanism where conditionals narrow union types based on predicates - after if (mt? t), the type of t refines from BT (union) to just mt in that branch, implementing Flow-sensitive typin

A type system mechanism where **conditionals narrow union types** based on predicates - after `if (mt? t)`, the type of `t` refines from `BT` (union) to just `mt` in that branch, implementing ${fref("/01-programming-language-theory/02-concepts/flow-sensitive-typing.td")}.

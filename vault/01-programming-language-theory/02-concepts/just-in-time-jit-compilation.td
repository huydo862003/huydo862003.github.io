---
_type: PltConcept
_label: 'Just-in-time (JIT) compilation'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/01-programming-language-theory/02-concepts/evaluator.td")} that starts out as an ${fref("/01-programming-language-theory/02-concepts/interpreter.td")} but includes a monitor to detect, compile and utilize compiled hot code.

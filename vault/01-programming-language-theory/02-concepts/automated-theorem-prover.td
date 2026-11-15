---
_type: PltConcept
_label: 'Automated theorem prover'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
tags:
  - 'formal system'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A tool that attempts to prove theorems automatically without human guidance, using techniques like resolution, rewriting, or SAT/SMT solving (contrast with interactive provers like ${fref("/01-programming-language-theory/02-concepts/coq.td")} that require u

A **tool** that attempts to prove theorems automatically without human guidance, using techniques like resolution, rewriting, or SAT/SMT solving (contrast with interactive provers like Rocq that require user-directed tactics).

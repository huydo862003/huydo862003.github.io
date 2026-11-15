---
_type: PltConcept
_label: 'Proof assistant/prover'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Logic, Proof/Reason technique, Formal system) A **tool** that helps users construct and verify formal proofs, combining human guidance with automated checking (like Rocq, Lean, Isabelle).

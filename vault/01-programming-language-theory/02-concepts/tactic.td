---
_type: PltConcept
_label: 'Tactic'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

::: info
(Language feature/design, Formal system, Proof/Reason technique) A **proof Command** in ${fref("/01-programming-language-theory/02-concepts/rocq.td")} that transforms the current ${fref("/01-programming-language-theory/02-concepts/goal.td")} state, automating proof steps (like `intros`, `apply`, `rewrite`) to incrementally construct a proof term.
:::

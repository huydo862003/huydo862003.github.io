---
_type: PltConcept
_label: 'Tactic'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
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
(Language feature/design, Formal system, Proof/Reason technique) A **proof Command** in ${fref("/programming-language-theory/concepts/rocq.td")} that transforms the current ${fref("/programming-language-theory/concepts/goal.td")} state, automating proof steps (like `intros`, `apply`, `rewrite`) to incrementally construct a proof term.
:::

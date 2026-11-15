---
_type: PltConcept
_label: 'Proof by simplification'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'logic'
  - 'programming paradigm'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

::: info
(Proof/Reason technique, Logic) A [proof technique](/programming-language-theory/concepts/proof-technique) that reduces expressions to simpler forms using definitional equalities, [computation rule](/programming-language-theory/concepts/computation-rule)s, or algebraic identities.
:::

::: info
(Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) [Rocq] A Proof technique in Rocq (via `simpl` or `reflexivity`) that reduces expressions using Computation rules (unfolding, beta reduction, pattern matching).
:::

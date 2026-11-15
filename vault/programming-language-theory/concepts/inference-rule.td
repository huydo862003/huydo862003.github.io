---
_type: PltConcept
_label: 'Inference rule'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Logic) A formal statement consisting of ${fref("/programming-language-theory/concepts/premise.td")}s and a ${fref("/programming-language-theory/concepts/conclusion.td")}, asserting that if all premises hold, the conclusion may be derived.
:::

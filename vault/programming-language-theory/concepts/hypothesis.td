---
_type: PltConcept
_label: 'Hypothesis'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Formal system, Proof/Reason technique, Language feature/design) [Rocq] A **named assumption** in the proof context that can be used to justify proof steps, introduced by tactics like `intros` or `assert`.
:::

---
_type: PltConcept
_label: 'Proof technique'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'logic'
  - 'programming paradigm'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) [Rocq] In Rocq, a **conceptual strategy** for proving goals (like induction or case analysis), typically realized by corresponding tactics.
:::

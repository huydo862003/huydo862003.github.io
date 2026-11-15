---
_type: PltConcept
_label: 'Command'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

[Rocq] A **top-level directive** in Rocq that controls the environment (like `Definition`, `Theorem`, `Print`, `Check`) rather than operating within a proof.

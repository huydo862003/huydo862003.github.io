---
_type: PltConcept
_label: 'Type variable'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A placeholder (e.g., $T$, $U$, $\\alpha$) representing an unknown or generic type - gets instantiated to a concrete type during type checking or remains polymorphic.

A **placeholder** (e.g., $T$, $U$, $\alpha$) representing an unknown or generic type - gets instantiated to a concrete type during type checking or remains polymorphic.

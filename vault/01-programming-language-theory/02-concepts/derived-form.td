---
_type: PltConcept
_label: 'Derived form'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A construct that adds no expressive power but can be translated into more primitive forms, e.g., $\text{let}\ x = s\ \text{in}\  t$ desugars to $(\lambda x.\ t)\ s$.

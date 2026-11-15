---
_type: PltConcept
_label: 'Refined type'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type that carries additional constraints beyond the base type, such as \"positive integers\" or \"non-null strings\". Enables more precise specifications and stronger compile-time guarantees.

A type that carries additional constraints beyond the base type, such as "positive integers" or "non-null strings". Enables more precise specifications and stronger compile-time guarantees.

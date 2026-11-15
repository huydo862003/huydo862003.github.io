---
_type: PltConcept
_label: 'Unwrap'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An operation that extracts inner values from a wrapper type via ${fref("/01-programming-language-theory/02-concepts/pattern-matching.td")} (like getting x from Some x), exposing the contained data for use.

An **operation** that extracts inner values from a wrapper type via pattern matching (like getting `x` from `Some x`), exposing the contained data for use.

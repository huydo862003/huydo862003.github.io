---
_type: PltConcept
_label: 'Unwrap'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An operation that extracts inner values from a wrapper type via ${fref("/programming-language-theory/concepts/pattern-matching.td")} (like getting x from Some x), exposing the contained data for use.

An **operation** that extracts inner values from a wrapper type via pattern matching (like getting `x` from `Some x`), exposing the contained data for use.

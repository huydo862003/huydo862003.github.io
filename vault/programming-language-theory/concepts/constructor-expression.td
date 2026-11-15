---
_type: PltConcept
_label: 'Constructor expression'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

[Rocq] An **expression** that applies a [constructor](/programming-language-theory/concepts/constructor) to arguments to build a value of an [inductive type](/programming-language-theory/concepts/inductive-type) (like `S (S O)` for 2, or `Some 42` for an optional integer).

---
_type: PltConcept
_label: 'Representation'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A concrete encoding of abstract data (e.g., the numeral 5 can be represented as \"101\", S(S(S(S(S O)))), or 0x05).

A **concrete encoding** of abstract data (e.g., the numeral `5` can be represented as `"101"`, `S(S(S(S(S O))))`, or `0x05`).

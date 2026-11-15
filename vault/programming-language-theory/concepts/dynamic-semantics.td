---
_type: PltConcept
_label: 'Dynamic semantics'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The meaning of programs in terms of their runtime behavior - how expressions evaluate, statements execute, and state changes over time.

The **meaning of programs** in terms of their runtime behavior - how expressions evaluate, statements execute, and state changes over time. Contrast with ${fref("/programming-language-theory/concepts/static-semantics.td")}.

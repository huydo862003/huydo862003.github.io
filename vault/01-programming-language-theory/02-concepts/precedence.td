---
_type: PltConcept
_label: 'Precedence'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A parsing rule that determines which operator binds tighter (e.g., `*` before `+` makes `1 + 2 * 3` parse as `1 + (2 * 3)`).

A **parsing rule** that determines which operator binds tighter (e.g., `*` before `+` makes `1 + 2 * 3` parse as `1 + (2 * 3)`).

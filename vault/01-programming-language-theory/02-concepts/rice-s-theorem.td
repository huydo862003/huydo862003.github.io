---
_type: PltConcept
_label: 'Rice''s theorem'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'logic'
  - 'program analysis'
tags:
  - 'computation theory'
  - 'logic'
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A theorem stating that any non-trivial semantic property of programs is ${fref("/01-programming-language-theory/02-concepts/decidability.td")} - we cannot automatically determine arbitrary properties about what programs compute (e.g., "does this function always return a positive number?"), which is why type systems must be conservative approximations.

A theorem stating that any **non-trivial semantic property** of programs is **undecidable** - we cannot automatically determine arbitrary properties about what programs compute (e.g., "does this function always return a positive number?"), which is why type systems must be conservative approximations.

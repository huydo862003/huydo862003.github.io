---
_type: PltConcept
_label: 'Flow typing'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system feature where a variable's type changes based on control flow - after if (x != null), the type of x narrows from T | null to T.

A type system feature where a variable's type **changes** based on control flow - after `if (x != null)`, the type of `x` narrows from `T | null` to `T`.

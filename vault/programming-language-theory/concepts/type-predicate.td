---
_type: PltConcept
_label: 'Type predicate'
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

A function that tests whether a value belongs to a specific type and informs the ${fref("/programming-language-theory/concepts/type-checker.td")} of this fact - enables ${fref("/programming-language-theory/concepts/type-narrowing.td")} after the check (e.g., mt?, string?, typeof).

A function that tests whether a value belongs to a specific type and **informs the type checker** of this fact - enables narrowing after the check (e.g., `mt?`, `string?`, `typeof`).

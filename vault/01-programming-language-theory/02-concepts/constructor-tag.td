---
_type: PltConcept
_label: 'Constructor tag'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A runtime marker that distinguishes which variant of a ${fref("/01-programming-language-theory/02-concepts/sum-type.td")} a value belongs to, enabling ${fref("/01-programming-language-theory/02-concepts/pattern-matching.td")} to dispatch on the correct case. Not to be confused with ${fref("/01-programming-language-theory/02-concepts/type-variant.td")}s, which are static properties.

---
_type: PltConcept
_label: 'Union type'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Union type: An untagged, ad-hoc combination of existing independent types (e.g., (U mt node)) - unlike ${fref("/01-programming-language-theory/02-concepts/sum-type.td")} (${fref("/01-programming-language-theory/02-concepts/algebraic-data-type.td")}) where ${fref("/01-programming-language-theory/02-concepts/type-variant.td")} are tagged and defined together as part of one

**Union type:** An **untagged**, **ad-hoc** combination of existing independent types (e.g., `(U mt node)`) - unlike Sum type (Algebraic data types) where Type variant are **tagged** and **defined together** as part of one type.

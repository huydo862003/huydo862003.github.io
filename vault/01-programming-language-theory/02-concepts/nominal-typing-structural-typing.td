---
_type: PltConcept
_label: 'Nominal typing structural typing'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system where ${fref("/01-programming-language-theory/02-concepts/type-compatibility.td")} is determined by **explicit declarations** (class names, inheritance hierarchy), not structure - `class A` and `class B` are different even if identical in shape.

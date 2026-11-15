---
_type: PltConcept
_label: 'Sum type union type'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An algebraic datatype with **multiple ${fref("/01-programming-language-theory/02-concepts/type-variant.td")}**s combined via "or" - a value is **one of** the variants, each with its own **${fref("/01-programming-language-theory/02-concepts/constructor-tag.td")}** (e.g., `BT = mt | node`).

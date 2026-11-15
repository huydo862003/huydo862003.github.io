---
_type: PltConcept
_label: 'Premise'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An antecedent judgment in an ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")} that must be ${fref("/01-programming-language-theory/02-concepts/derivable.td")} for the rule to derive its ${fref("/01-programming-language-theory/02-concepts/conclusion.td")}.

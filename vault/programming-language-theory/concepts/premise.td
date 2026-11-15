---
_type: PltConcept
_label: 'Premise'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An antecedent judgment in an ${fref("/programming-language-theory/concepts/inference-rule.td")} that must be ${fref("/programming-language-theory/concepts/derivable.td")} for the rule to derive its ${fref("/programming-language-theory/concepts/conclusion.td")}.

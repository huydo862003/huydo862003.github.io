---
_type: PltConcept
_label: 'Conclusion'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The consequent ${fref("/programming-language-theory/concepts/judgment.td")} of an ${fref("/programming-language-theory/concepts/inference-rule.td")} that is derived when all its ${fref("/programming-language-theory/concepts/premise.td")}s are satisfied.

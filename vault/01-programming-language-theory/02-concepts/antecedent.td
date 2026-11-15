---
_type: PltConcept
_label: 'Antecedent'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The part above the line in a typing rule - the ${fref("/01-programming-language-theory/02-concepts/premise.td")}s that must hold before the ${fref("/01-programming-language-theory/02-concepts/conclusion.td")} can be drawn (\"if\" part).

The part **above** the line in a typing rule - the Premises that must hold before the Conclusion can be drawn ("if" part).

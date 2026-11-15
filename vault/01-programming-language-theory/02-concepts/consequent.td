---
_type: PltConcept
_label: 'Consequent'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The part below the line in a typing rule - the ${fref("/01-programming-language-theory/02-concepts/conclusion.td")} that follows when all ${fref("/01-programming-language-theory/02-concepts/antecedent.td")}s are satisfied (\"then\" part).

The part **below** the line in a typing rule - the Conclusion that follows when all Antecedents are satisfied ("then" part).

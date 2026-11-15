---
_type: PltConcept
_label: 'Logic'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
tags:
  - 'formal system'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/formal-system.td")} for reasoning about truth, validity, and inference, defining syntax for propositions and rules for deriving conclusions.

A **formal system** for reasoning about truth, validity, and inference, defining syntax for propositions and rules for deriving conclusions.

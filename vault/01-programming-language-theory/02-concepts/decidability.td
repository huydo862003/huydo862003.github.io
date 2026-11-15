---
_type: PltConcept
_label: 'Decidability'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'logic'
tags:
  - 'computation theory'
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A property of a problem or language where an algorithm exists that can always determine the correct yes/no answer in finite time for any input.

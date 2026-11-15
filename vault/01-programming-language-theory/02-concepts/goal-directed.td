---
_type: PltConcept
_label: 'Goal-directed'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of an algorithm that is aware of its goal and uses that knowledge to take educated steps towards the goal, or in the case of ${fref("/01-programming-language-theory/02-concepts/backward-chaining-search.td")}, starting from the goal, and working backwards towards the ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s.

---
_type: PltConcept
_label: 'Backward chaining'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A proof technique for ${fref("/01-programming-language-theory/02-concepts/judgment.td")}s that starts from the desired judgement and works backwards towards the ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s.

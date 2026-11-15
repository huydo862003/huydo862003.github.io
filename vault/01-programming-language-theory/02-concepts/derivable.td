---
_type: PltConcept
_label: 'Derivable'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
  - 'logic'
  - 'set theory & relation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A property of an ${fref("/01-programming-language-theory/02-concepts/evaluation-statement-judgement.td")} that it can be derived using the evaluation rules in the calculus.

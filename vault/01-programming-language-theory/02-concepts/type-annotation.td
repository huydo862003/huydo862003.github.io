---
_type: PltConcept
_label: 'Type annotation'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic hint to the ${fref("/01-programming-language-theory/02-concepts/type-checker.td")} declaring the intended type of a term, used to guide inference, resolve ambiguity, or make types explicit for documentation.

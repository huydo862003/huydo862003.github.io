---
_type: PltConcept
_label: 'Partiality'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'semantics'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of a computation that may not terminate or produce a result for all inputs. ${fref("/01-programming-language-theory/02-concepts/partial-function.td")}s are undefined for some inputs, unlike ${fref("/01-programming-language-theory/02-concepts/total-function.td")}s which always return a value.

---
_type: PltConcept
_label: 'Map-Reduce'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'programming paradigm'
tags:
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/programming-model.td")} that processes large datasets by applying a function to each element (map) then combining results with an associative operation (reduce), enabling parallelization.

A **programming model** that processes large datasets by applying a function to each element (map) then combining results with an associative operation (reduce), enabling parallelization.

---
_type: PltConcept
_label: 'Lambda expression'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic construct denoting an anonymous function, consisting of a list of ${fref("/01-programming-language-theory/02-concepts/formal-parameter.td")}s and a body - e.g., $\lambda x.\ t$ or $(\text{lambda}\ (x)\ t)$.

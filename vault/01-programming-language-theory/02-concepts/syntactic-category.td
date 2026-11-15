---
_type: PltConcept
_label: 'Syntactic category'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages, largely analogous with ${fref("/01-programming-language-theory/02-concepts/sort.td")}. Roughly means "syntactic type".
:::

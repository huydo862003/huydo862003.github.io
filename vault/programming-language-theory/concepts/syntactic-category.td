---
_type: PltConcept
_label: 'Syntactic category'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages, largely analogous with ${fref("/programming-language-theory/concepts/sort.td")}. Roughly means "syntactic type".
:::

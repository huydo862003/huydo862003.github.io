---
_type: PltConcept
_label: 'Type safety'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Type theory, Language feature/design, Semantics) According to Robert (Bob) Harper, the coherence between ${fref("/01-programming-language-theory/02-concepts/static-semantics.td")} and ${fref("/01-programming-language-theory/02-concepts/dynamic-semantics.td")}.
:::

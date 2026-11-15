---
_type: PltConcept
_label: 'Strict/Eager evaluation strategy'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Language feature/design) An ${fref("/01-programming-language-theory/02-concepts/evaluation-strategy.td")} such that an argument is evaluated before passing into the function call.
:::

---
_type: PltConcept
_label: 'Lazy evaluation strategy'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Language feature/design) An ${fref("/programming-language-theory/concepts/evaluation-strategy.td")} in which the argument is not evaluated before substituted into the function call.
:::

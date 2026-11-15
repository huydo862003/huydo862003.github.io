---
_type: PltConcept
_label: 'Function'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Language feature/design) A reusable piece of code that returns a result.
:::

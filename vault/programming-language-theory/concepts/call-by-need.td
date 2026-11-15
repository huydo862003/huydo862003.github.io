---
_type: PltConcept
_label: 'Call by need'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Lambda calculus, Semantics, Pure lambda calculus) An evaluation strategy similar to ${fref("/programming-language-theory/concepts/call-by-name.td")}, but terms' values are cached to avoid re-evaluation.
:::

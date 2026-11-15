---
_type: PltConcept
_label: 'Constructor'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Programming paradigm, Language feature/design) In languages with [closure](/programming-language-theory/concepts/closure)s or prototypes, a function that returns objects of similar shapes.
:::

::: info
(Language feature/design) [Rocq] A **value builder** in Rocq that introduces inhabitants of an [inductive type](/programming-language-theory/concepts/inductive-type) (like `O` and `S` for `nat`, or `Some` and `None` for `option`), enabling [pattern matching](/programming-language-theory/concepts/pattern-matching) and [structural recursion](/programming-language-theory/concepts/structural-recursion).
:::

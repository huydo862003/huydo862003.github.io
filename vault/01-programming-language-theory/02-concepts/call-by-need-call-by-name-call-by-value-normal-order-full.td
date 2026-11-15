---
_type: PltConcept
_label: 'Call by need call by name call by value normal order full'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Lambda calculus, Semantics, Pure lambda calculus) An evaluation strategy similar to ${fref("/01-programming-language-theory/02-concepts/call-by-name.td")}, but terms' values are cached to avoid re-evaluation.
:::

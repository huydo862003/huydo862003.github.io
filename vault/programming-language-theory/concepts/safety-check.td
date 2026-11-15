---
_type: PltConcept
_label: 'Safety check'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'language feature/design'
  - 'programming paradigm'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mechanism, either carried out by the runtime to enforce ${fref("/programming-language-theory/concepts/language-safety.td")} / avoid ${fref("/programming-language-theory/concepts/runtime-type-error.td")} or by programmers to avoid ${fref("/programming-language-theory/concepts/runtime-error.td")}.

---
_type: PltConcept
_label: 'Shadowing'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The phenomenon when an inner ${fref("/programming-language-theory/concepts/binding.td")} uses the same name as an outer binding, making the outer one inaccessible within the inner ${fref("/programming-language-theory/concepts/scope.td")}.

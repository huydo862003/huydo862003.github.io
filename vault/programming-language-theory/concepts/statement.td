---
_type: PltConcept
_label: 'Statement'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/term.td")} that does not evaluate to a value, but rather cause a ${fref("/programming-language-theory/concepts/side-effect.td")}.

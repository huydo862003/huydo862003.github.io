---
_type: PltConcept
_label: 'Closed term'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/lambda-term.td")} with no ${fref("/programming-language-theory/concepts/free-variable.td")}.

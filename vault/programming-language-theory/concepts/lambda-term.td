---
_type: PltConcept
_label: 'Lambda term'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Any expression in the ${fref("/programming-language-theory/concepts/lambda-calculus.td")} grammar: a variable, an ${fref("/programming-language-theory/concepts/lambda-abstraction.td")}, or an application.

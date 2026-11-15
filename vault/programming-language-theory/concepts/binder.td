---
_type: PltConcept
_label: 'Binder'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic construct that introduces a variable and defines its scope. In ${fref("/programming-language-theory/concepts/lambda-calculus.td")}, it's the variable directly following $\lambda$.

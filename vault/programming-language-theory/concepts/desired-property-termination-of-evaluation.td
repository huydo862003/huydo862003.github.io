---
_type: PltConcept
_label: 'Desired property: termination of evaluation'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A desirable property of a ${fref("/programming-language-theory/concepts/lambda-calculus.td")} where every term all evaluates to a ${fref("/programming-language-theory/concepts/normal-form.td")}, whether they become ${fref("/programming-language-theory/concepts/stuck-term.td")} or Value. This property may not hold in most systems.

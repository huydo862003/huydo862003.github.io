---
_type: PltConcept
_label: 'Desired property: uniqueness of normal forms'
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

A desirable property of a ${fref("/programming-language-theory/concepts/lambda-calculus.td")} where every term always evaluates to the same ${fref("/programming-language-theory/concepts/normal-form.td")}. This property should hold in all deterministic systems.

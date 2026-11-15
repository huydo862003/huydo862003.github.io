---
_type: PltConcept
_label: 'Eta-expansion'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The transformation of a term $t$ to $\lambda x.\ t\ x$ where $x \notin FV(f)$ - the inverse of ${fref("/01-programming-language-theory/02-concepts/eta-reduction.td")}, often used to delay evaluation or make function abstraction explicit.

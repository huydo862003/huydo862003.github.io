---
_type: PltConcept
_label: 'Eta-reduction'
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

The transformation of  $\lambda x.\ t\ x$  to $t$ where $x \notin FV(f)$ - eliminating a redundant ${fref("/01-programming-language-theory/02-concepts/lambda-abstraction.td")} when a function simply passes its argument unchanged to another function.

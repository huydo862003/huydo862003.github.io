---
_type: PltConcept
_label: 'Beta-equivalence'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/binary-relation.td")} that relates terms connected by ${fref("/01-programming-language-theory/02-concepts/beta-reduction.td")}  - $(\lambda x.\ t)\ s =_\beta [x\to s]t$ - capturing the fundamental computation rule of function application.

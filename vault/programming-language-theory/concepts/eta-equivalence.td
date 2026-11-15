---
_type: PltConcept
_label: 'Eta-equivalence'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A relation that relates a term to its ${fref("/programming-language-theory/concepts/eta-expansion.td")} - $\lambda x.\ f\ x =_\eta f$ when $x \notin FV(f)$ - capturing the principle that functions with identical input-output behavior are equivalent.

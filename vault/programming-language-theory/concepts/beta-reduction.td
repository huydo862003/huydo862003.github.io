---
_type: PltConcept
_label: 'Beta-reduction'
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

The act of reducing a ${fref("/programming-language-theory/concepts/beta-redex-reducible-expression.td")} by substituting the redex's argument into its function body.

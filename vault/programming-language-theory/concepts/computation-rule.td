---
_type: PltConcept
_label: 'Computation rule'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'semantics'
tags:
  - 'logic'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A rule performing an actual reduction step (e.g., ${fref("/programming-language-theory/concepts/beta-reduction.td")}), as opposed to ${fref("/programming-language-theory/concepts/congruence-rule.td")} which merely propagate evaluation into subterms.

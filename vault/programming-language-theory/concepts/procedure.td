---
_type: PltConcept
_label: 'Procedure'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A subroutine that performs actions primarily for ${fref("/programming-language-theory/concepts/side-effect.td")}s rather than returning a value. Unlike functions, procedures emphasize imperative steps over computation of results.

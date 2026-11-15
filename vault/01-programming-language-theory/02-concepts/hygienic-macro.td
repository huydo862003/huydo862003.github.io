---
_type: PltConcept
_label: 'Hygienic macro'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Hygienic macros are analogous to ${fref("/01-programming-language-theory/02-concepts/lexical-static-scope.td")} for ${fref("/01-programming-language-theory/02-concepts/macro.td")}s: Macro variables are not just names, but rather binding information records.

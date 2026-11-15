---
_type: PltConcept
_label: 'Macro definition hazard: duplication'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'design principle'
  - 'metaprogramming/self-reflection'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/macro.td")} pitfall where an expression passed as argument is evaluated multiple times in the ${fref("/programming-language-theory/concepts/macro-expansion.td")}, causing unintended repeated ${fref("/programming-language-theory/concepts/side-effect.td")}s or performance issues.

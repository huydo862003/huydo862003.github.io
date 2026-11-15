---
_type: PltConcept
_label: 'Macro definition hazard: duplication'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'design principle'
  - 'metaprogramming/self-reflection'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/macro.td")} pitfall where an expression passed as argument is evaluated multiple times in the ${fref("/01-programming-language-theory/02-concepts/macro-expansion.td")}, causing unintended repeated ${fref("/01-programming-language-theory/02-concepts/side-effect.td")}s or performance issues.

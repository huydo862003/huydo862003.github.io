---
_type: PltConcept
_label: 'Recursive macro'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/macro.td")} that can expand to code containing further macro invocations, including calls to itself. Enables powerful metaprogramming but requires careful handling to ensure termination.

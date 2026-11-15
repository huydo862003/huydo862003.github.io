---
_type: PltConcept
_label: 'Flow analysis'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A static analysis technique that tracks how information propagates through a program's control flow - determining what facts hold at each program point based on paths taken.

A ${fref("/programming-language-theory/concepts/static-analysis.td")} technique that tracks how **information propagates** through a program's control flow - determining what facts hold at each program point based on paths taken.

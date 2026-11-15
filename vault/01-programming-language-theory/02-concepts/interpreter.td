---
_type: PltConcept
_label: 'Interpreter'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'runtime'
tags:
  - 'compiler implementation'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Mathematically, denote $\mathcal{P}_L$ as the set of programs written in the language $L$ and $V$ the set of all possible values, an interpreter is a function $I: \mathcal{P}_L \to V$.

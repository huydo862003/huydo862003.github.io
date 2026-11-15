---
_type: PltConcept
_label: 'Assume-guarantee reasoning'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A pattern where interacting components have mutual obligations - one component assumes what another guarantees, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it;

A pattern where interacting components have **mutual obligations** - one component **assumes** what another **guarantees**, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it; application assumes function returns $U$, lambda guarantees it).

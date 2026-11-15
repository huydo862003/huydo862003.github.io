---
_type: PltConcept
_label: 'SMT solver'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/decision-procedure.td")} that determines satisfiability of formulas in first-order logic with theories (like arithmetic, arrays, bit-vectors), extending ${fref("/01-programming-language-theory/02-concepts/sat-solver.td")} to richer domains.

A **decision procedure** that determines satisfiability of formulas in first-order logic with theories (like arithmetic, arrays, bit-vectors), extending SAT to richer domains.

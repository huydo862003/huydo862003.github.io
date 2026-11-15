---
_type: PltConcept
_label: 'Subgoal'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'logic'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Formal system, Proof/Reason technique, Logic) A **subsidiary goal** generated when a proof splits into multiple cases, each requiring independent proof before the original ${fref("/programming-language-theory/concepts/goal.td")} is resolved.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) In ${fref("/programming-language-theory/concepts/rocq.td")}, a **derived goal** created when a ${fref("/programming-language-theory/concepts/tactic.td")} splits the proof into multiple obligations (e.g., one per constructor or conjunct), all of which must be discharged.

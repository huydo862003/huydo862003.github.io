---
_type: PltConcept
_label: 'Subgoal'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'logic'
  - 'proof/reason technique'
---

Tools: Rocq (formerly Coq)

- (Formal system, Proof/Reason technique, Logic) A **subsidiary goal** generated when a proof splits into multiple cases, each requiring independent proof before the original ${fref("/01-programming-language-theory/02-concepts/goal.td")} is resolved.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) In ${fref("/01-programming-language-theory/02-concepts/rocq.td")}, a **derived goal** created when a ${fref("/01-programming-language-theory/02-concepts/tactic.td")} splits the proof into multiple obligations (e.g., one per constructor or conjunct), all of which must be discharged.

---
_type: Concept
_label: 'Subgoal'
title: 'Subgoal'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
tags:
  - 'language-feature-design'
  - 'logic'
  - 'proof-reason-technique'
---

Tools: Rocq (formerly Coq)

- (Formal system, Proof/Reason technique, Logic) A **subsidiary goal** generated when a proof splits into multiple cases, each requiring independent proof before the original ${fref("programming-language-theory/concepts/goal.td")} is resolved.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) In ${fref("programming-language-theory/concepts/rocq.td")}, a **derived goal** created when a ${fref("programming-language-theory/concepts/tactic.td")} splits the proof into multiple obligations (e.g., one per constructor or conjunct), all of which must be discharged.

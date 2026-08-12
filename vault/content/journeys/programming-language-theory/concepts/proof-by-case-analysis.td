---
_type: Concept
title: 'Proof by case analysis'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
tags:
  - 'formal-system'
  - 'language-feature-design'
  - 'logic'
  - 'programming-paradigm'
  - 'proof-reason-technique'
---

Tools: Rocq (formerly Coq)

- (Proof/Reason technique, Logic) A ${fref("journeys/programming-language-theory/concepts/proof-technique.td")} that considers all possible forms of a value or ${fref("journeys/programming-language-theory/concepts/proposition.td")} separately, proving the ${fref("journeys/programming-language-theory/concepts/goal.td")} holds in each case.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) A **proof technique** in Rocq (via `destruct` or `case`) that splits a Goal into Subgoals for each constructor of an inductive type.

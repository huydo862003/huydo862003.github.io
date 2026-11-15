---
_type: PltConcept
_label: 'Proof by case analysis'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'logic'
  - 'programming paradigm'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Proof/Reason technique, Logic) A ${fref("/programming-language-theory/concepts/proof-technique.td")} that considers all possible forms of a value or ${fref("/programming-language-theory/concepts/proposition.td")} separately, proving the ${fref("/programming-language-theory/concepts/goal.td")} holds in each case.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) A **proof technique** in Rocq (via `destruct` or `case`) that splits a Goal into Subgoals for each constructor of an inductive type.

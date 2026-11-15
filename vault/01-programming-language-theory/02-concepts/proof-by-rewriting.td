---
_type: PltConcept
_label: 'Proof by rewriting'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'logic'
  - 'programming paradigm'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

- (Proof/Reason technique, Logic) A ${fref("/01-programming-language-theory/02-concepts/proof-technique.td")} that transforms expressions by substituting equals for equals, using known equalities to reshape the ${fref("/01-programming-language-theory/02-concepts/goal.td")}.
- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) Rocq A Proof techniques in Rocq (via `rewrite`) that substitutes equals for equals using a known equality to transform the Goal.

---
_type: PltConcept
_label: 'Goal'
journey: fref("/programming-language-theory/index.td")
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

Tools: Rocq (formerly Coq)

- (Formal system, Proof/Reason technique, Language feature/design, Programming paradigm) In ${fref("/programming-language-theory/concepts/rocq.td")}, the ${fref("/programming-language-theory/concepts/proposition.td")} **to be proven** at any point during a proof, which ${fref("/programming-language-theory/concepts/tactic.td")}s transform until it becomes trivially true.
- (Formal system, Proof/Reason technique, Logic) A ${fref("/programming-language-theory/concepts/proposition.td")} to be proven.

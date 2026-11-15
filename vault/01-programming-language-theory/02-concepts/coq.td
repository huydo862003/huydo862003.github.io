---
_type: PltConcept
_label: 'Coq'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'programming paradigm'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Programming paradigm, Language feature/design, Formal system, Proof/Reason technique) The **former name** of the ${fref("/01-programming-language-theory/02-concepts/rocq.td")} proof assistant (1984-2024), still widely used in literature and older documentation.

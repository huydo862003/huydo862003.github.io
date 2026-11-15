---
_type: PltConcept
_label: 'Rocq kernel'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
tags:
  - 'compiler implementation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Compiler implementation) The **trusted core** of Rocq that type-checks proof terms against the Calculus of Inductive Constructions, ensuring all accepted proofs are valid.

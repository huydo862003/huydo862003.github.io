---
_type: PltConcept
_label: 'Rocq'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Tools: Rocq (formerly Coq)

- (Formal system, Language feature/design, Proof/Reason technique) An **interactive theorem prover** (formerly Coq) that enables formal verification of mathematical proofs and program correctness, using ${fref("/01-programming-language-theory/02-concepts/dependent-type.td")}s and the ${fref("/01-programming-language-theory/02-concepts/calculus-of-inductive-construction.td")}.

- Name history

    Formerly Coq (after Thierry Coquand + CoC abbreviation + the French rooster symbolizing pride), renamed Rocq in 2024 (honoring Rocquencourt, Inria's founding site, and evoking the roc, a mythical bird of strength).

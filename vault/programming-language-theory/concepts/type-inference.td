---
_type: PltConcept
_label: 'Type inference'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The automatic deduction of types from program context without explicit annotations, using constraint solving or unification algorithms (e.g., ${fref("/programming-language-theory/concepts/hindley-milner-system.td")}) to determine (usually) the most general types.

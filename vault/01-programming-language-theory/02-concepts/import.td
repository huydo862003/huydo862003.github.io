---
_type: PltConcept
_label: 'Import'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

[Rocq] A **command** in Rocq:(/programming-language-theory/02-concepts/rocq) that brings names from a loaded [module](/programming-language-theory/02-concepts/module) into the current namespace, allowing unqualified access (often combined as `Require Import`).

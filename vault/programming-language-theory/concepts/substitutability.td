---
_type: PltConcept
_label: 'Substitutability'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The semantic/behavioral property that one value can safely replace another without breaking program correctness, of which ${fref("/programming-language-theory/concepts/type-compatibility.td")} is a static approximation of.

The semantic/behavioral property that one value can **safely replace** another without breaking program correctness, of which ${fref("/programming-language-theory/concepts/type-compatibility.td")} is a static approximation of.

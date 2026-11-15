---
_type: PltConcept
_label: 'Class extension'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

(Java) The { ... } part in class Sub extends Sup { ... }, can be conceptually viewed as a ${fref("/programming-language-theory/concepts/mixin.td")} specifically applied to Sup.

(Java) The `\{ ... \}` part in `class Sub extends Sup \{ ... \}`, can be conceptually viewed as a Mixin specifically applied to `Sup`.

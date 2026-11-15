---
_type: PltConcept
_label: 'Intro pattern'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'proof/reason technique'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

[Rocq] A [tactic modifier](/programming-language-theory/concepts/tactic-modifier) in Rocq:(/programming-language-theory/concepts/rocq) that destructures [hypothesis](/programming-language-theory/concepts/hypothesis)es as they're introduced (like `intros [x y]` to unpack a pair or `intros [H|H]` for a disjunction).

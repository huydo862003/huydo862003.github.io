---
_type: PltConcept
_label: 'Dynamic scope'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

This is considered unambiguously wrong in language design - it makes programs unpredictable and tools unreliable.

This is considered **unambiguously wrong** in language design - it makes programs unpredictable and tools unreliable.

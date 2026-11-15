---
_type: PltConcept
_label: 'Context-free'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A grammar where production rules depend only on a single non-terminal, not its surroundings - parsers handle this level; e.g., balanced parentheses, syntax structure.

A grammar where production rules depend only on a **single non-terminal**, not its surroundings - parsers handle this level; e.g., balanced parentheses, syntax structure.

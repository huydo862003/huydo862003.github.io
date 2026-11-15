---
_type: PltConcept
_label: 'Context-sensitive'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A grammar where production rules can depend on surrounding symbols (context) - type systems handle this level; e.g., \"variable must be declared before use\" requires checking context of the usage site.

A grammar where production rules can depend on **surrounding symbols** (context) - type systems handle this level; e.g., "variable must be declared before use" requires checking context of the usage site.

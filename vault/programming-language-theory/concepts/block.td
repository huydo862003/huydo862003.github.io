---
_type: PltConcept
_label: 'Block'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic construct that groups statements and typically introduces a new scope for local bindings - delimited by braces { }, keywords (begin/end), or indentation depending on the language.

A syntactic construct that groups statements and typically introduces a new scope for local bindings - delimited by braces `{ }`, keywords (`begin`/`end`), or indentation depending on the language.

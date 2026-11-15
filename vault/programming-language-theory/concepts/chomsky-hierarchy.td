---
_type: PltConcept
_label: 'Chomsky hierarchy'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
tags:
  - 'linguistics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A classification of formal grammars by expressiveness - from simplest to most powerful: regular, ${fref("/programming-language-theory/concepts/context-free.td")} (parsers), ${fref("/programming-language-theory/concepts/context-sensitive.td")} (type systems), recursively enumerable; explains why parsing

A classification of formal grammars by **expressiveness** - from simplest to most powerful: regular, **context-free** (parsers), **context-sensitive** (type systems), recursively enumerable; explains why parsing and type checking are **separate phases** with different complexity.

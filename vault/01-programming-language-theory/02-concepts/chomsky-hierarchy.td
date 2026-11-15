---
_type: PltConcept
_label: 'Chomsky hierarchy'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
tags:
  - 'linguistics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A classification of formal grammars by expressiveness - from simplest to most powerful: regular, ${fref("/01-programming-language-theory/02-concepts/context-free.td")} (parsers), ${fref("/01-programming-language-theory/02-concepts/context-sensitive.td")} (type systems), recursively enumerable; explains why parsing

A classification of formal grammars by **expressiveness** - from simplest to most powerful: regular, **context-free** (parsers), **context-sensitive** (type systems), recursively enumerable; explains why parsing and type checking are **separate phases** with different complexity.

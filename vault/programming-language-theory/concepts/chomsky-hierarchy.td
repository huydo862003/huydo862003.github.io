---
_type: Concept
_label: 'Chomsky hierarchy'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'linguistics'
---

A classification of formal grammars by expressiveness - from simplest to most powerful: regular, ${fref("programming-language-theory/concepts/context-free.td")} (parsers), ${fref("programming-language-theory/concepts/context-sensitive.td")} (type systems), recursively enumerable; explains why parsing

A classification of formal grammars by **expressiveness** - from simplest to most powerful: regular, **context-free** (parsers), **context-sensitive** (type systems), recursively enumerable; explains why parsing and type checking are **separate phases** with different complexity.

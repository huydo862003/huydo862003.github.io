---
_type: Concept
title: 'Chomsky hierarchy'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'linguistics'
---

A classification of formal grammars by expressiveness - from simplest to most powerful: regular, ${fref("journeys/programming-language-theory/concepts/context-free.td")} (parsers), ${fref("journeys/programming-language-theory/concepts/context-sensitive.td")} (type systems), recursively enumerable; explains why parsing

A classification of formal grammars by **expressiveness** - from simplest to most powerful: regular, **context-free** (parsers), **context-sensitive** (type systems), recursively enumerable; explains why parsing and type checking are **separate phases** with different complexity.

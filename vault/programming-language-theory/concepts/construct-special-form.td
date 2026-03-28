---
_type: Concept
_label: 'Construct/Special form'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
tags:
  - 'language-feature-design'
  - 'semantics'
  - 'syntax grammar'
---

A built-in language primitive with special evaluation rules that cannot be implemented as a regular function (e.g., `if`, `lambda`, `define` in Lisp). In other words, special forms are necessary for cases where ${fref("programming-language-theory/concepts/derived-form.td")}s do not suffice.

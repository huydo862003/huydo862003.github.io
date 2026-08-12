---
_type: Concept
title: 'Pair encoding'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'lambda-calculus'
  - 'semantics'
---

Encoding:

- $\text{pair} = \lambda f.\ \lambda s.\ \lambda t.\ t\ f\ s$
- $\text{fst} = \lambda p.\ p\  \text{tru}$
- $\text{snd} = \lambda p.\ p\ \text{fls}$

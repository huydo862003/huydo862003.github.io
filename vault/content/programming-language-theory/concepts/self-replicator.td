---
_type: Concept
_label: 'Self-replicator'
title: 'Self-replicator'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'lambda-calculus'
  - 'semantics'
---

Example:

$$
\text{fibo} = \text{fix}\ \lambda f.\ \lambda n.\ \text{if}\ n = 0\ \text{or}\ n = 1\ \text{then}\ 1\ \text{else}\ (f\ (n - 1)) + (f\ (n - 2))
$$

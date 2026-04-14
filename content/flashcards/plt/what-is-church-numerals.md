---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: "What is church numerals?"
answer: TODO
deck: pure-lambda-calculus
concepts:
  - pure-untyped-lambda-calculus
  - church-numeral
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags: []
keywords:
  - "pure untyped lambda calculus"
  - "church numeral"
  - "lambda"
  - "church"
  - "numerals"
  - "encoding"
  - "natural"
  - "numbers"
---


Church numerals is an encoding of natural numbers in Pure/Untyped lambda calculus.

$$
c_n = \lambda a.\ \lambda z.\ a\ (a\ (...\ z)\ ...)
$$

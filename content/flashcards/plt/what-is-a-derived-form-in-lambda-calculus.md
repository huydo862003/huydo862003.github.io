---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is a derived form in lambda calculus?
deck: pure-lambda-calculus
concepts:
  - derived-form
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags: []
---

A construct that adds no expressive power but can be translated into more primitive forms, e.g., $\text{let}\ x = s\ \text{in}\  t$ desugars to $(\lambda x.\ t)\ s$.

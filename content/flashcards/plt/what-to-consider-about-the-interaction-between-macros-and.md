---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What to consider about the interaction between macros and side effects?
deck: programming-language-basic
concepts:
  - macro
books:
  - chapter-3-syntactic-sugar
tags: []
---

An argument to the macro can be substituted multiple times into the macro's body, causing the argument to be evaluated multiple times. If the argument evaluation has side effects, it can be confusing.

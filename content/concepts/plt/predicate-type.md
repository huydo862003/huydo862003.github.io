---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Predicate type
journey: plt
status: reviewing
books:
  - chapter-5-types
dependsOn: []
blocks: []
tags:
  - language-feature-design
  - program-analysis
  - runtime
  - semantics
  - type-theory
---

A function type annotated with what it proves when returning true - e.g., (-> Any Boolean : mt) means \"takes anything, returns Boolean, and when true, input was mt.\" Essentially, a type of a Type pred

A function type annotated with **what it proves** when returning true - e.g., `(-> Any Boolean : mt)` means "takes anything, returns Boolean, and when true, input was `mt`." Essentially, a type of a Type predicate.

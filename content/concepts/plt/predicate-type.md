---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Predicate type"
description: "A function type annotated with what it proves when returning true - e.g., (-> Any Boolean : mt) means \"takes anything, returns Boolean, and when true, input was mt.\" Essentially, a type of a Type pred"
journey: plt
status: reviewing
books: ["chapter-5-types"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "program-analysis"
  - "runtime"
  - "semantics"
  - "type-theory"
keywords:
  - "type"
  - "predicate"
  - "boolean"
  - "function"
  - "annotated"
  - "proves"
  - "returning"
---
author: hdnax

A function type annotated with **what it proves** when returning true - e.g., `(-> Any Boolean : mt)` means "takes anything, returns Boolean, and when true, input was `mt`." Essentially, a type of a Type predicate.

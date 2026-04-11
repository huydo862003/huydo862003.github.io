---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Left-left-lambda"
description: "\"Left-left-lambda\" is a concept in plt (status: mastered). Topics: language-feature-design, programming-paradigm, syntax-grammar."
journey: plt
status: mastered
books: ["chapter-3-syntactic-sugar"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "programming-paradigm"
  - "syntax-grammar"
  - "lambda"
  - "left-left-lambda"
  - "scheme"
  - "body"
  - "arg"
  - "opening"
  - "parens"
  - "reading"
  - "left-to-right"
---

```scheme
((lambda (x) body) arg)
│││
│││
│└┴── lambda
└┴─── left left (two opening parens)
```

Reading left-to-right: `(` `(` `lambda` → "left-left-lambda".

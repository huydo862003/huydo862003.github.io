---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Left-left-lambda"
journey: plt
status: mastered
tags: ["language-feature-design", "programming-paradigm", "syntax-grammar"]
books: ["chapter-3-syntactic-sugar"]
dependsOn: []
blocks: []
---

```scheme
((lambda (x) body) arg)
│││
│││
│└┴── lambda
└┴─── left left (two opening parens)
```

Reading left-to-right: `(` `(` `lambda` → "left-left-lambda".

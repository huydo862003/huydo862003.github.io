---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Z-combinator"
description: "Formula: $\\lambda f.\\ (\\lambda x.\\ f\\ (\\lambda v.\\ x\\ x\\ v))\\ (\\lambda x.\\ f\\ (\\lambda v.\\ x\\ x\\ v))$"
journey: plt
status: learning
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "lambda-calculus"
  - "semantics"
keywords:
  - "lambda"
  - "text"
  - "fix"
  - "aligned"
  - "z-combinator"
  - "formula"
  - "details"
  - "begin"
  - "mapsto"
  - "end"
---

Formula: $\lambda f.\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))$

- Details
    
    $$
\begin{aligned}
\text{fix}\ g
&\to [f \mapsto g] (\lambda x.\ f\ (\lambda v.\ x\ x\ v))\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v )) \\
&\to (\lambda x.\ g\ (\lambda v.\ x\ x\ v)) (\lambda x.\ g\ (\lambda v.\ x\ x\ v)) \\
&\to [x \to \lambda x.\ g\ (\lambda v.\ x\ x\ v)]g\ (\lambda v.\ x\ x\ v) \\
&\to g\ (\lambda v.\ (\lambda x.\ g\ (\lambda v.\ x\ x\ v))\ (\lambda v.\ (\lambda x.\ g\ (\lambda v.\ x\ x\ v))\ v) \\
&= g\ (\lambda v.\ (\text{fix}\ g)\ v)
\end{aligned}
$$
    
    In call-by-value, $\text{fix}\ g$ doesn't diverge as there a thunk wrapping around the nested $\text{fix}\ g$.

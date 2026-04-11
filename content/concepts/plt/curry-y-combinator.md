---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Curry/Y-Combinator"
description: "\\text{fix} = \\lambda f.\\ (\\lambda x.\\ f\\ (x\\ x))\\ (\\lambda x.\\ f (x\\ x))"
journey: plt
status: reviewing
books: ["chapter-5-the-untyped-pure-lambda-calculus"]
dependsOn: []
blocks: []
tags:
  - "lambda-calculus"
  - "semantics"
  - "lambda"
  - "text"
  - "fix"
  - "aligned"
  - "evaluation"
  - "strategy"
  - "curry"
  - "y-combinator"
  - "details"
  - "begin"
---

$$
\text{fix} = \lambda f.\ (\lambda x.\ f\ (x\ x))\ (\lambda x.\ f (x\ x))
$$

- Details
    
    $$
\begin{aligned}
\text{fix}\ g
&\to [f \mapsto g] (\lambda x.\ f\ (x\ x))\ (\lambda x.\ f\ (x\ x)) \\
&\to (\lambda x.\ g\ (x\ x)) \ (\lambda x.\ g\ (x\ x)) \\
&\to [x \to \lambda x.\ g\ (x\ x)] g\ (x\ x) \\
&\to g\ ((\lambda x.\ g\ (x\ x))\  (\lambda x.\ g\ (x\ x))) \\
&= g\ (\text{fix}\ g)
\end{aligned}
$$
    
    - In a call-by-value evaluation strategy, this diverges because it continues to evaluate $\text{fix}\ g$.
    - In a call-by-name evaluation strategy, $\text{fix}\ g$ does not diverge because $g$ gets applied to $\text{fix}\ g$.

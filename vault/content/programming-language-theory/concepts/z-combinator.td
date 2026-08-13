---
_type: Concept
_label: 'Z-combinator'
title: 'Z-combinator'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'lambda-calculus'
  - 'semantics'
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

    In ${fref("programming-language-theory/concepts/call-by-value.td")}, $\text{fix}\ g$ doesn't diverge as there a thunk wrapping around the nested $\text{fix}\ g$.

---
_type: PltConcept
_label: 'Z-combinator'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
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

    In ${fref("/01-programming-language-theory/02-concepts/call-by-value.td")}, $\text{fix}\ g$ doesn't diverge as there a thunk wrapping around the nested $\text{fix}\ g$.

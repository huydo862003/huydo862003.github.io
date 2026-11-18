---
_type: PltConcept
_label: 'Curry/Y-Combinator'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
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

  - In a ${fref("/01-programming-language-theory/02-concepts/call-by-value.td")} evaluation strategy, this diverges because it continues to evaluate $\text{fix}\ g$.
  - In a ${fref("/01-programming-language-theory/02-concepts/call-by-name.td")} evaluation strategy, $\text{fix}\ g$ does not diverge because $g$ gets applied to $\text{fix}\ g$.

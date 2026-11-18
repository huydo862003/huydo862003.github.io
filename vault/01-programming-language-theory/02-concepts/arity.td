---
_type: PltConcept
_label: 'Arity'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'semantics'
  - 'set theory & relation'
  - 'syntax & grammar'
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , a syntactic type signature of an ${fref("/01-programming-language-theory/02-concepts/operator.td")}, determining the ${fref("/01-programming-language-theory/02-concepts/sort.td")} of an operator and the number and the sorts of the arguments expected by the operator.
:::

Example: In the context of ${fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")}s, if an operator $o$ has an arity $(s_1, \dots, s_n)s$ for $s, s_1, \dots, s_n \in \mathcal{S}$, then $o(a_1, \dots, a_n)$ is of sort $s$ if $a_i$ is of sort $s_i$.

Example: In the context of ${fref("/01-programming-language-theory/02-concepts/abstract-binding-tree-abt.td")}s, if an operator $o$ has an arity $(v_1, \dots, v_n)s$, where $s \in \mathcal{S}$ and $v_i$ is$s_1, \dots, s_k.s$, then $o(\vec{x}_1.a_1, \dots, \vec{x}_n.a_n)$ is of sort $s$ if $\vec{x}_i.a_i$ has the corresponding ${fref("/01-programming-language-theory/02-concepts/valence.td")} $v_i$.

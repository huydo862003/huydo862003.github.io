---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Arity"
description: "(Syntax & Grammar) According to Practical foundations for programming languages , a syntactic type signature of an Operator, determining the Sort of an operator and the number and the sorts of the arg"
journey: plt
status: mastered
books: ["chapter-5-types", "chapter-1-abstract-syntax"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "semantics"
  - "set-theory-relation"
  - "syntax-grammar"
  - "dots"
  - "operator"
  - "sort"
  - "arity"
  - "vec"
  - "context"
  - "mathcal"
  - "key"
---
:::key
(Syntax & Grammar) According to Practical foundations for programming languages , a syntactic type signature of an Operator, determining the Sort of an operator and the number and the sorts of the arguments expected by the operator.
:::

Example: In the context of ASTs, if an operator $o$ has an arity $(s_1, \dots, s_n)s$ for $s, s_1, \dots, s_n \in \mathcal{S}$, then $o(a_1, \dots, a_n)$ is of sort $s$ if $a_i$ is of sort $s_i$.

Example: In the context of ABTs, if an operator $o$ has an arity $(v_1, \dots, v_n)s$, where $s \in \mathcal{S}$ and $v_i$ is$s_1, \dots, s_k.s$, then $o(\vec{x}_1.a_1, \dots, \vec{x}_n.a_n)$ is of sort $s$ if $\vec{x}_i.a_i$ has the corresponding Valence $v_i$.

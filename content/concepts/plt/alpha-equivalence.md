---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Alpha-equivalence
description: "Then, $=_\\alpha$ is the strongest Congruence on $\\mathcal{A}$that contains the followings:"
journey: plt
status: learning
books:
  - chapter-1-abstract-syntax
dependsOn: []
blocks: []
tags: []
keywords:
  - "mathcal"
  - "vec"
  - "alpha"
  - "set"
  - "family"
  - "fresh"
  - "rho"
  - "leftrightarrow"
  - "asts"
  - "sort-indexed"
---

- Formal definition according to Practical foundations for programming languages 
    
    Consider:
    
    - A fixed set of Sorts $\mathcal{S}$, which categorize ASTs into Syntactic category.
    - A sort-indexed family of Variables $\mathcal{X} = \{ \mathcal{X}_s \}$, where $\mathcal{X}_s$ is the set of variables with sort $\mathcal{S}$. A sequence of variable is written as $\vec{x}$.
    - A sort-indexed family of [Abstract syntax tree (AST)](/journeys/plt/concepts/abstract-syntax-tree-ast)s $\mathcal{A} = \{\mathcal{A}_s \}$, where $\mathcal{A}_s$ is the set of ASTs with sort $\mathcal{S}$.
    - An arity-indexed family of Operators $\mathcal{O}= \{\mathcal{O}_\alpha\}$, where $\mathcal{O}_\alpha$ is the set of operators with the given arity $\alpha$.
    - A fresh renaming with respect to $\mathcal{X}$ is a bijection $\rho : \vec{x} \leftrightarrow \vec{y}$ such that $\vec{y}$ is fresh in $\mathcal{X}$.
    
    Then, $=_\alpha$ is the **strongest Congruence** on $\mathcal{A}$that contains the followings:
    
    - For $x \in \mathcal{X}$, then $x =_\alpha x$.
    - For $o \in \mathcal{O}$, then $o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n) =_\alpha o(\vec{x}'_1.a'_1; \dots; \vec{x}'_n.a'_n)$ if for every $1 \leq i \leq n$, $\hat{\rho}_i(a_i) =_\alpha \hat{\rho}'_i(a'_i)$ for all fresh renamings $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho'_i : \vec{x}'_i \leftrightarrow \vec{z}_i$.

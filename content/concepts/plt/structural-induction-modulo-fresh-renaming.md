---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Structural induction modulo fresh renaming"
description: "To show that $\\mathcal{P}[\\mathcal{X}](a)$ holds for every $a \\in \\mathcal{B}[\\mathcal{X}]$, it is enough to show the following:"
journey: plt
status: reviewing
books: ["chapter-1-abstract-syntax"]
dependsOn: []
blocks: []
tags:
  - "proof-reason-technique"
  - "syntax-grammar"
keywords:
  - "mathcal"
  - "vec"
  - "set"
  - "variables"
  - "show"
  - "dots"
  - "structural"
  - "induction"
  - "modulo"
  - "fresh"
---
author: hdnax

- Formulation
    
    Consider:
    
    - A set of sorts $\mathcal{S}$.
    - A set of variables $\mathcal{X}$.
    - A predicate $\mathcal{P}$ that is parameterized by $\mathcal{X}$ and $s$.
    - A set of abstract binding trees $\mathcal{B}$ with free variables in $\mathcal{X}$.
    
    To show that $\mathcal{P}[\mathcal{X}](a)$ holds for every $a \in \mathcal{B}[\mathcal{X}]$, it is enough to show the following:
    
    1. If $x \in \mathcal{X}_s$, then $\mathcal{P}[\mathcal{X}]_s(x)$.
    2. For every $o$ of arity $(\vec{s}_1.s_1;\dots;\vec{s}_n.s_n).s$, if for each $1 \le i \le n$, $\mathcal{P}[\mathcal{X},\vec{x}'_i]_{s_i}(\hat{\rho}_i(a_i))$ for every $\rho_i : \vec{x}_i \leftrightarrow \vec{x}_i'$ with $\vec{x}'_i \notin \mathcal{X}$, then $\mathcal{P}[\mathcal{X}]_s (o(\vec{x}_1.a_1 ; \dots ;\vec{x}_n .a_n))$.

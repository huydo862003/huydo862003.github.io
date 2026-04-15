---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What does it mean for a collection of inference rules to form the strongest judgment form that is closed under those rules?
deck: proof-technique
concepts: []
books:
  - chapter-2-inductive-definitions
tags: []
---

A collection of inference rules is taken to specify a judgment form - assuming it's $-\ J$ - that is:

- The strongest judgment form:
    - That means $J$ cannot contain elements whose membership cannot be inferred from these inference rules.
    
    → $a \in J$ implies that $a\ J$ can be proven.
    
- Closed under the inference rules:
    - That means $J$ must contain all elements whose membership can be inferred from these inference rules.
    
    → $a\ J$ can be proven implies that $a \in J$.

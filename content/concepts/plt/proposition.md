---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Proposition"
journey: plt
status: mastered
books: ["chapter-1-basics-functional-programming-in-rocq"]
dependsOn: []
blocks: []
tags:
  - "logic"
---

→ true/false do not merely \"corresponds to reality.\"

- In Intuitionistic/Constructive logic
    - `true` means "has a proof".
    - `false` means "has a refutation"
    
    → `true`/`false` do not merely "corresponds to reality."
    
    - Classical logic treats propositions as having truth values in some Platonic realm.
    - Intuitionistic/Constructive logic rejects this: a proposition is a problem to be solved. Asserting $P$ means "I have a construction that demonstrates $P$."
        
        → Kolmogorov called Proposition *Aufgaben* (tasks) - a proposition is something you do, not something that is.
        
- Propositions vs. Booleans
    
    In the context of Intuitionistic/Constructive logic.
    
    - A proposition is not a boolean.
    - Conflating them is called Boolean blindness.
    
    |    | Proposition |  Boolean  |
    |  ---  | --- |  ---  |
    |  What it is  | An assertion with proof/refutation |  A data value: `true` or `false`  |
    |  "True" means  | Has a proof |  Equals the value `true`  |
    |  "False" means  | Has a refutation |  Equals the value `false`  |
    |  Computable?  | Not in general |  Always-it's just a bit  |
    
    **Example.** Consider equality of functions $f, g : \mathbb{N} \to \mathbb{N}$.
    
    - The proposition $f = g$ is legitimate - you can prove it by showing they agree on all inputs.
    - The boolean $f == g$ is not computable-you would have to check infinitely many inputs.
    
    → The proposition exists and can be reasoned about.
    
    → The boolean cannot be computed.
    
    → Conflating them causes confusion.

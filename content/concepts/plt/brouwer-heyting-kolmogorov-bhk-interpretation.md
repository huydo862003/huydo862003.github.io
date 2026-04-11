---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Brouwer-Heyting-Kolmogorov (BHK) interpretation"
description: "Motivation. Classical logic tells you *that* something exists, not *how* to find it. BHK says to prove something exists, you must exhibit a witness."
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "logic"
  - "semantics"
keywords:
  - "exists"
  - "bhk"
  - "prove"
  - "proofs"
  - "text"
  - "half"
  - "derivation"
  - "witness"
  - "method"
---

- Intuitionistic logic is syntax-the formal rules.
- BHK is semantics-what those rules *mean*.
- For intuitionistic logic, there can be other interpretations (multiple semantics for the same language).

**Motivation.** Classical logic tells you *that* something exists, not *how* to find it. BHK says to prove something exists, you must exhibit a witness.

| To prove... | You must... |
| --- | --- |
| $A \wedge B$ |  Prove both  |
| $A \lor B$ |  Prove one (and say which)  |
| $A \to B$ | Give a method converting proofs of $A$ into proofs of $B$ |
 | $\existsx.\ P(x)$ | Produce a specific $x$ and prove $P(x)$ | 
| $\forall x.\ P(x)$ | Give a method that proves $P(x)$ for any $x$ |

**Significance.** This makes proofs computational-a proof of $\existsx.\ P(x)$ is an algorithm that outputs a witness.

- Example
    
    Suppose we have:
    
    - A proof $p$ that $A$ holds.
    - A function $f$ that transforms proofs of $A$ into proofs of $B(t)$ for some specific $t$.
    
    We want to derive $\exists x.\; B(x)$.
    
    **The derivation (syntax)**
    
    $$
    \frac{\dfrac{p : A \quad f : A \to B(t)}{B(t)} \; (\to\text{-elim})}{\exists x.\; B(x)} \; (\exists\text{-intro})
    $$
    
    **The proof object (BHK)**
    
    |  Step  | Rule |  BHK construction  |
    |  ---  | --- |  ---  |
    |  We have  | (assumption) | $p$ is a proof of $A$ | 
     | We have |  (assumption)  | $f$ is a function $A \to B(t)$ | 
     | Apply $f$ to $p$ | $(\to\text{-elim})$ | $f(p)$ is a proof of $B(t)$ | 
| Package with witness | $(\exists\text{-intro})$ | $\langle t, f(p) \rangle$ is a proof of $\exists x.\; B(x)$ |
    
    **Reading it together.** The derivation tree:
    
    $$
    \frac{\displaystyle\frac{p \quad f}{f(p) : B(t)}}{\langle t, f(p) \rangle : \exists x.\; B(x)}
    $$
    
    - Each horizontal line is a rule.
    - Each expression below the line is the BHK object built from the objects above.
    - The complete derivation *is* the construction recipe.
    
    **Concrete instance.** Let $A$ be "$n$ is even" and $B(x)$ be "$x$ is the half of $n$."
    
    |  We have  | BHK object | 
     | --- |  ---  |
    | $p$ : proof that $4$ is even | (e.g., $4 = 2\times 2$) |
     | $f$ : method that, given evenness proof, computes half | $f(p) = 2$ with proof | 
| Conclusion | $\langle 2, f(p) \rangle$ proves $\exists x.\; x \text{ is half of } 4$ |
    
    The derivation doesn't just say a half exists - it yields the half.

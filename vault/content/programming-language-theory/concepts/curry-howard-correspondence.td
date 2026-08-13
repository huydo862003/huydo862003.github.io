---
_type: Concept
_label: 'Curry-Howard correspondence'
journey: fref("programming-language-theory/index.td")
status: 'learning'
tags:
  - 'logic'
  - 'semantics'
  - 'type-theory'
---

**Remark. [Brouwer-Heyting-Kolmogorov (BHK) interpretation](/programming-language-theory/concepts/brouwer-heyting-kolmogorov-bhk-interpretation)** makes this correspondence explicit:

- Propositions ~ types.
- Proofs ~ terms inhabiting those types.

| Logic | Programming |
| --- | --- |
| Proposition $A$ | Type $A$ |
| Proof of $A$ | Term of type $A$ |
| $A \to B$ | Function type $A \to B$ |
| $A \land B$ | Product type $A \times B$ |
| $A \lor B$ | [Sum type](/programming-language-theory/concepts/sum-type) $A + B$ |
| $\forall x.\ P(x)$ | Dependent function $\Pi_{x} P(x)$ |
| $\exists x.\ P(x)$ | Dependent pair $\Sigma_{x} P(x)$ |

- BHK: A proof of $A \to B$ is a function transforming proofs of $A$ into proofs of $B$.
- Program: A term of type $A\to B$ is a function transforming terms of type $A$ to terms of type $B$.

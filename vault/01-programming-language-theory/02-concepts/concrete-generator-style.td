---
_type: PltConcept
_label: 'Concrete generator style'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'set theory & relation'
  - 'syntax & grammar'
---

A style of formal definition that defines a set as a union of a sequence $S_0 \\subseteq S_1 \\subseteq \\dots$  where each $S_{i+1}$ is built from $S_i$ using rules - e.g., for naturals: $S_0 = \\emptyset$

A style of formal definition that defines a set as a union of a sequence $S_0 \subseteq S_1 \subseteq \dots$  where each $S_{i+1}$ is built from $S_i$ using rules - e.g., for naturals: $S_0 = \emptyset$, $S_{i+1} = S_i \cup {0} \cup {succ(n) | n \in S_i}, \mathbb{N} = \bigcup S_i$.

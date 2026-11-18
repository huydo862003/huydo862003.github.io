---
_type: PltConcept
_label: 'Law of excluded middle (LEM)'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'logic'
  - 'syntax & grammar'
---

holds. It asserts that every statement is either true or false, with no middle ground.

$$
A \lor \neg A
$$

**Remark.** Classical logic accepts this as an ${fref("/01-programming-language-theory/02-concepts/axiom.td")}. ${fref("/01-programming-language-theory/02-concepts/intuitionistic-constructive-logic.td")} rejects it: asserting $A \lor \neg A$ requires either a proof of $A$ or a proof of $\neg A$, and for many statements we have neither.

---
_type: Concept
title: 'Law of excluded middle (LEM)'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
tags:
  - 'logic'
  - 'syntax-grammar'
---

holds. It asserts that every statement is either true or false, with no middle ground.

$$
A \lor \neg A
$$

**Remark.** Classical logic accepts this as an ${fref("programming-language-theory/concepts/axiom.td")}. ${fref("programming-language-theory/concepts/intuitionistic-constructive-logic.td")} rejects it: asserting $A \lor \neg A$ requires either a proof of $A$ or a proof of $\neg A$, and for many statements we have neither.

---
_type: Concept
title: 'Double negation elimination'
journey: fref("journeys/programming-language-theory/index.td")
status: 'reviewing'
tags:
  - 'logic'
  - 'syntax-grammar'
---

holds. It asserts that if it is false that $A$ is false, then $A$ is true.

$$
\neg\neg A \to A
$$

**Remark.** Classical logic accepts this. ${fref("journeys/programming-language-theory/concepts/intuitionistic-constructive-logic.td")} rejects it: showing that $\neg A$ leads to contradiction is not the same as constructing a proof of $A$. You have ruled something out, but you have not built the required ${fref("journeys/programming-language-theory/concepts/witness.td")}.

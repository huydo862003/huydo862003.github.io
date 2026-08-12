---
_type: Concept
title: 'Backward chaining search goal directed'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

A search strategy for a ${fref("programming-language-theory/concepts/derivation.td")} of some ${fref("programming-language-theory/concepts/judgment.td")} that starts from the desired Judgment as the initial goal, picks a rule at each step with the conclusion as the current goal, adds its premises as subgoals into a queue & continues until all subgoals are ${fref("programming-language-theory/concepts/axiom.td")}s.

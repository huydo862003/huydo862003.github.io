---
_type: PltConcept
_label: 'Double negation elimination'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'logic'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

holds. It asserts that if it is false that $A$ is false, then $A$ is true.

$$
\neg\neg A \to A
$$

**Remark.** Classical logic accepts this. ${fref("/01-programming-language-theory/02-concepts/intuitionistic-constructive-logic.td")} rejects it: showing that $\neg A$ leads to contradiction is not the same as constructing a proof of $A$. You have ruled something out, but you have not built the required ${fref("/01-programming-language-theory/02-concepts/witness.td")}.

---
_type: PltConcept
_label: 'Backward chaining search backward chaining'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A search strategy for a ${fref("/01-programming-language-theory/02-concepts/derivation.td")} of some ${fref("/01-programming-language-theory/02-concepts/judgment.td")} that starts from the desired Judgment as the initial goal, picks a rule at each step with the conclusion as the current goal, adds its premises as subgoals into a queue & continues until all subgoals are ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s.

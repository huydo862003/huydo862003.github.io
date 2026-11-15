---
_type: PltConcept
_label: 'Forward chaining search backward chaining search'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A search strategy for a ${fref("/01-programming-language-theory/02-concepts/derivation.td")} of a ${fref("/01-programming-language-theory/02-concepts/judgment-form.td")} that keeps track of the currently derivable judgments (initially the ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s) and tries to expand the set using the rules at each step.

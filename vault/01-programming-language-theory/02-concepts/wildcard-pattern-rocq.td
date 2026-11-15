---
_type: PltConcept
_label: 'Wildcard pattern rocq'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/pattern.td")} (usually written `_`) that matches any value without binding it to a name, useful for ignoring irrelevant cases in ${fref("/01-programming-language-theory/02-concepts/pattern-matching.td")}.

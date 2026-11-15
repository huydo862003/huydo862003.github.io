---
_type: PltConcept
_label: 'Iterated inductive definition simultaneous inductive'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/01-programming-language-theory/02-concepts/inductive-definition.td")} technique that specifies a set of elements as the strongest sets closed under a set of ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s - each inference rule may only refer to already defined sets or the currently defined one.

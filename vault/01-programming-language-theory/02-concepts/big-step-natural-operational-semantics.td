---
_type: PltConcept
_label: 'Big-step/Natural operational semantics'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'semantics'
tags:
  - 'formal system'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A style of semantic which defines evaluation via ${fref("/01-programming-language-theory/02-concepts/evaluation-statement-judgement.td")} of the form $t \\Downarrow v$, relating a term directly to its final value in a single derivation rather than through int

A style of semantic which defines evaluation via Evaluation statement/judgement of the form $t \Downarrow v$, relating a term directly to its final value in a single derivation rather than through intermediate steps.

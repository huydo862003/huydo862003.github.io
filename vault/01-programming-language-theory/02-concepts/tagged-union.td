---
_type: PltConcept
_label: 'Tagged union'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonym for ${fref("/01-programming-language-theory/02-concepts/sum-type.td")} - "union" because it combines variants, "tagged" because each variant has an explicit ${fref("/01-programming-language-theory/02-concepts/constructor-tag.td")} distinguishing it (unlike untagged ${fref("/01-programming-language-theory/02-concepts/union-type.td")} types).

Synonym for Sum type - "union" because it combines variants, "tagged" because each variant has an explicit Constructor tag distinguishing it (unlike **untagged** Union type types).

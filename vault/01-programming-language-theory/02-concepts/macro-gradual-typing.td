---
_type: PltConcept
_label: 'Macro gradual typing'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/gradual-typing.td")} approach where typed and untyped code exist as two separate sibling languages that interact only at module boundaries, typically requiring ${fref("/01-programming-language-theory/02-concepts/blame-tracking.td")}.

A Gradual typing approach where typed and untyped code exist as **two separate sibling languages** that interact only at **module boundaries**, typically requiring Blame tracking.

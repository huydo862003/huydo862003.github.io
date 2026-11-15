---
_type: PltConcept
_label: 'Type safety language safety'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The property of a language in which every well-typed program (accepted by the static semantics typing rules) will **never reach a “stuck term” state** due to *misusing values according to their types*.

According to Robert (Bob) Harper, the coherence between static semantics and [dynamic semantics](/programming-language-theory/concepts/dynamic-semantics).

---
_type: PltConcept
_label: 'Compiler'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
tags:
  - 'compiler implementation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Mathematically, denote $\\mathcal{P}_S$ as the set of programs in the source language and $\\mathcal{P}_T$ as the set of programs in the target language. Then, a compiler is a function $C: \\mathcal{P}_S \\to \\mathcal{P}_T$

Mathematically, denote $\mathcal{P}_S$ as the set of programs in the source language and $\mathcal{P}_T$ as the set of programs in the target language. Then, a compiler is a function $C: \mathcal{P}_S \to \mathcal{P}_T$.

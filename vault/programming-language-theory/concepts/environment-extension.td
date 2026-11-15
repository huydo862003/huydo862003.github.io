---
_type: PltConcept
_label: 'Environment extension'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The operation $\\Gamma[x \\leftarrow t]$ that creates a new environment with all bindings from $\\Gamma$ plus variable $x$ bound to term/type/etc. $t$.

The operation $\Gamma[x \leftarrow t]$ that creates a **new** ${fref("/programming-language-theory/concepts/environment.td")} with all bindings from $\Gamma$ plus variable $x$ bound to term/type/etc. $t$.

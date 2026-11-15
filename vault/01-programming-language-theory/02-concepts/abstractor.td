---
_type: PltConcept
_label: 'Abstractor'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

- Practical foundations for programming languages 's notation

    $x_1,\dots, x_n.a$ -> Within $a$, we can additionally use $x_1,\dots, x_n$.

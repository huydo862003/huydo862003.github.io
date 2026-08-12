---
_type: Flashcard
question: "What is the inductive definition of a judgment form?"
deck: 'set-theory-relation'
concepts:
  - fref("journeys/programming-language-theory/concepts/inductive-definition.td")
  - fref("journeys/programming-language-theory/concepts/judgment-form.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
---

::: flashcard
${question}
=== key
Assume a judgment form $-\ J$, the inductive definition of $J$ would be a set of Rules, typically starting with some Axioms then some Proper rules to derive membership of $J$. Then, $J$ is taken to be the strongest set closed under those rules.
:::

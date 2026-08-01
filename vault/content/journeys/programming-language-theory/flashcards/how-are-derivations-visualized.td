---
_type: Flashcard
question: "How are derivations visualized?"
deck: 'proof-technique'
concepts:
  - fref("journeys/programming-language-theory/concepts/derivation.td")
  - fref("journeys/programming-language-theory/concepts/derivation-tree.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
---

::: flashcard
${question}
=== key
Derivation tree:

- The root is the desired judgment.
- Each node other than the root is an intermediate judgment.
- All the children of a node represent its premises.
:::

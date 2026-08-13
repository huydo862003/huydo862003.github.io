---
_type: Book
_label: 'Part I. Untyped systems'
journey: fref("programming-language-theory/index.td")
parent: fref("programming-language-theory/books/types-and-programming-languages/index.td")
children:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-3-untyped-arithmetic-expressions.td")
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-4-an-ml-implementation-of-arithmetic-expressions.td")
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

- To rigorously discuss type systems, it is essential to establish **clear, precise, and mathematically tractable tools** for expressing and reasoning about **program syntax and semantics**.
- Initial focus (chapters 3 & 4):
  - Subject: A **trivial small language** consisting only of numbers and booleans.
  - Concepts:
    - Abstract syntax.
    - Inductive definitions.
    - Inductive proofs.
    - Inductive evaluation (operational semantics).
    - The modeling of run-time errors.
- **Next steps (chapters 5-7):**
  - Subject: The **untyped lambda-calculus** (a much more powerful language).
  - Concepts: Dealing formally with **name binding** and **substitution**.
- **Introducing type systems (Chapter 8 onwards):**
  - Chapter 8: Returns to the simple language (numbers and booleans) to introduce the basic concepts of **static typing**.
  - Chapter 9: Extends these concepts to the **lambda-calculus**.

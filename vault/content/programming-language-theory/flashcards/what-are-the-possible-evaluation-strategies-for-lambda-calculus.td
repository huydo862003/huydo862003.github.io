---
_type: Flashcard
_label: 'What are the possible evaluation strategies for lambda calculus?'
deck: 'pure-lambda-calculus'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What are the possible evaluation strategies for lambda calculus?
=== key
- Full beta-reduction.

    Any redexes can be reduced.

- Normal order.

    Only the left-most outermost redex can be reduced.

- Call by name.

    Normal order but nested redex inside labda abstractions cannot be reduced.

- Call by need.

    Call by name but with caching to avoid recomputation.

- Call by value.

    Redexes can only be reduced if their argument is a value.
:::

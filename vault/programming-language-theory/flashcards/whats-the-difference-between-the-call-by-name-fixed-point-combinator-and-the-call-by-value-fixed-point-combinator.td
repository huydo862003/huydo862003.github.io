---
_type: PltFlashcard
_label: 'What''s the difference between the call-by-name fixed-point combinator and the call-by-value fixed-point combinator?'
deck: 'pure-lambda-calculus'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What's the difference between the call-by-name fixed-point combinator and the call-by-value fixed-point combinator?
=== key
- Call-by-name fixed-point combinator - Curry/Y-Combinator:

    $$
    Y = \lambda f.\ (\lambda x.\ f\ x\ x)\ (\lambda x.\ f\ x\ x)
    $$

    -> Used in call-by-name languages because of the lazy evaluation strategy.

    -> Not used in call-by-value languages because it always diverges when applied to a function

- Call-by-value fixed-point combinator - Z-combinator:

    $$
    Z = \lambda f.\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))
    $$

    -> Used in call-by-value languages.
:::

---
_type: Flashcard
_label: 'What''s the relation between the y-combinator and the omega combinator?'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/divergent-big-omega-combinator.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What's the relation between the y-combinator and the omega combinator?
=== key
The small omega combinator:

$$
\omega = \lambda x.\ x\ x
$$

The big omega combinator:

$$
\Omega = (\lambda x.\ x\ x)
\ (\lambda x.\ x\ x)
$$

The Y-combinator:

$$
Y = \lambda f.\ (\lambda x.\ f\ x\ x)\ (\lambda x.\ f\ x\ x)
$$

Some similarities in structure:

- Each term in the Y-combinator's body is a slightly modified version of the small omega combinator - $\lambda x.\ f\ x\ x$ vs $\lambda x.\ x\ x$.
- Self-application pattern.
:::

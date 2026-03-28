---
_type: Concept
_label: 'Variable capture'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'lambda calculus'
  - 'semantics'
---

Example:

$$
(\lambda x.\ \lambda y.\ x)\ y \to [x \to y] \lambda y.\ x = \lambda y.\ y
$$

So, $y$ was a free variable and not bound by the $\lambda y$ binder in the first term, but then become bound in the resulting term.

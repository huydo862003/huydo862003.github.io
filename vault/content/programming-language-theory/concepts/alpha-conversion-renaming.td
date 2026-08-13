---
_type: Concept
_label: 'Alpha conversion/renaming'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'lambda-calculus'
  - 'semantics'
---

Example:

$$
(\lambda x.\ \lambda y.\ x)\ y \to [x \to y] \lambda y.\ x
$$

Without alpha-conversion, performing a naive substitution would result in:

$$
[x \to y]\lambda y.\ x = \lambda y.\ \ y
$$

So, a function that was always returning a constant $x$ becomes an identity function.

With alpha-conversion, we can correctly perform a substitution:

$$
[x \to y] \lambda y.\ x = [x \to y]\lambda z.\ x = \lambda z.\ y
$$

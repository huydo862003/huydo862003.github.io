---
_type: Flashcard
_label: 'How to use fix to define recursive functions?'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/fixed-point-combinator.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
How to use fix to define recursive functions?
=== key
Sketch a normal recursive function as you will in regular programming languages:

```tsx
function fact(n: number): number {
	if (n == 0) return 1;
	return n * fact(n - 1);
}
```

Rewrite it to a recursive variable definition:

```tsx
const fact = function (n: number): number {
	if (n == 0) return 1;
	return n * fact(n - 1);
}
```

In Pure/Untyped lambda calculus, recursive definition like this is not possible as we don't really have an "assignment" operator, make the recursive function a parameter (a Self-replicator):

```tsx
(fct) => (n) => {
	if (n == 0) return 1;
	return n * fct(n - 1);
}
```

Then, we can write it in Pure/Untyped lambda calculus as follows:

$$
\lambda\text{fact}.\ \lambda n.\ \text{if}\ n = 0\ \text{then}\ 1\ \text{else}\ n * \text{fact}(n - 1)
$$

We can finally define the recursive function as:

$$
\text{fix}\ \lambda\text{fact}.\ \lambda n.\ \text{if}\ n = 0\ \text{then}\ 1\ \text{else}\ n * \text{fact}(n - 1)
$$
:::

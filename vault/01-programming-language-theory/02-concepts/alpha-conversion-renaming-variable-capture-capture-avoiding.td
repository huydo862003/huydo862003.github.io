---
_type: PltConcept
_label: 'Alpha conversion renaming variable capture capture avoiding'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
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

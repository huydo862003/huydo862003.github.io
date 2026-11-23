---
_type: PltBook
_label: "Exercise 2.55: Car of double-quoted symbol"
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Eva Lu Ator types `(car ''abracadabra)` and the interpreter prints `quote`. Explain.

**Answer**: The interpreter syntactically parses `'` as a call to `quote`:

```
''abracadabra  →  (quote (quote abracadabra))
```

Evaluating `(quote (quote abracadabra))` returns the list `(quote abracadabra)` — a two-element list with the symbol `quote` and the symbol `abracadabra`.

Calling `car` on that list returns the first element: the symbol `quote`.

---
_type: PltBook
_label: 'Exercise 1.39'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: A continued fraction representation of the tangent function was published in 1770 by the German math-
ematician J.H. Lambert:

$$
\tan x = \displaystyle \frac{x}{1 - \frac{x^2}{3 - \frac{x^2}{5 - \cdots}}}
$$

where `x` is in radians. Define a procedure `(tan-cf x k)` that computes an approximation to the tangent function based on Lambert’s formula. `k` specifies the number of terms to compute, as in Exercise 1.37.


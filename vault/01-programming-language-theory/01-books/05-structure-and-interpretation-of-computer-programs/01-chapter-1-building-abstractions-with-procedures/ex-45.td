---
_type: PltBook
_label: 'Exercise 1.45'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: We saw in Section 1.3.3 that attempting to compute square roots by naively finding a fixed point of `y -> x/y` does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped `y -> x/y^2`. Unfortunately, the process does not work for fourth roots—a single average damp is not enough to make a fixed-point search for `y -> x/y^3` converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of `y -> x/y^3)` the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute nth roots as a fixed-point search based upon repeated average damping of `y -> x/y^(n-1)`. Use this to implement a simple procedure for computing nth roots using `fixed-point`, `average-damp`, and the repeated procedure of Exercise 1.43. Assume that any arithmetic operations you need are available as primitives.


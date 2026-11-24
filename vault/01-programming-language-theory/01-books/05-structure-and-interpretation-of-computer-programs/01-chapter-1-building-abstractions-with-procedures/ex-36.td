---
_type: PltBook
_label: 'Exercise 1.36'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Modify `fixed-point` so that it prints the sequence of approximations it generates, using the `newline` and `display` primitives shown in Exercise 1.22. Then find a solution to $x^x = 1000$ by finding a fixed point of $x -> log(1000)/log(x)$. (Use Scheme’s primitive `log` procedure, which computes natural logarithms.) Compare the number of steps this takes with and without average damping. (Note that you cannot start fixed-point with a guess of `1`, as this would cause division by `log(1) = 0`.)


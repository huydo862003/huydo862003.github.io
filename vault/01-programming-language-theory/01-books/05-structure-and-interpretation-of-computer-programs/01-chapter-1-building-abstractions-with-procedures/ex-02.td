---
_type: PltBook
_label: 'Exercise 1.2: Translate expression to prefix form'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Translate the following expression into prefix form:

$$\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3(6 - 2)(2 - 7)}$$

**Answer**:

```scheme
(/ (+ (+ 5 4)
      (- 2
         (- 3
            (+ 6
               (/ 4 5)))))
   (* (* 3
         (- 6 2))
      (- 2 7)))
```

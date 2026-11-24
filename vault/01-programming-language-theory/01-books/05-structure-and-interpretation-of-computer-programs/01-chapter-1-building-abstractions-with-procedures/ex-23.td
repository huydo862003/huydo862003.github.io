---
_type: PltBook
_label: 'Exercise 1.23: Optimized prime search (skip even divisors)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Modify the prime test to skip even divisors (test 2, then 3, 5, 7, 9, ...). Does this make it run twice as fast?

**Answer**: Skip even divisors after 2 by checking divisibility by 2 separately, then searching only odd divisors starting from 3.

```scheme
(define (prime? n)
  (define (find-odd-divisor start-divisor)
    (cond ((> (* start-divisor start-divisor) n) n)
          ((divides? start-divisor n) start-divisor)
          (else (find-odd-divisor (+ start-divisor 2)))))
  (if (divides? 2 n)
    (= n 2)
    (= (find-odd-divisor 3) n)))
```

The speedup is less than 2× in practice, because the `next` procedure adds overhead that partially offsets the halved step count.

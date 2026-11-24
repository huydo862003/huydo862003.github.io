---
_type: PltBook
_label: 'Exercise 1.22: Search for primes with timing'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Write `search-for-primes` to find the three smallest primes larger than 1000; 10,000; 100,000; 1,000,000. Verify the `Θ(√n)` growth prediction.

**Answer**:

```scheme
(#%require (only racket/base current-inexact-milliseconds))
(define (runtime) (current-inexact-milliseconds))

(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (define (find-divisor start-divisor)
    (cond ((> (* start-divisor start-divisor) n) n)
          ((divides? start-divisor n) start-divisor)
          (else (find-divisor (+ start-divisor 1)))))
  (= (find-divisor 2) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      void))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (define (search-for-primes-iter i)
    (cond ((> i end) void)
          ((even? i) (search-for-primes-iter (+ i 1)))
          (else (timed-prime-test i)
                (search-for-primes-iter (+ i 2)))))
  (search-for-primes-iter start)
  (newline))
```

Timing results showed ~0.0017ms around 1000, ~0.0027ms around 10000. `sqrt(10) ≈ 3.16` but observed ratio is only ~1.6×, suggesting the program doesn't run strictly proportional to step count (caching, constant factors, etc.).

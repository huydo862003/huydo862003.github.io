---
_type: PltBook
_label: 'Exercise 2.29: Binary mobile'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Given a binary mobile represented as `(list left-branch right-branch)` and a branch as `(list length structure)`:

a. Define selectors.
b. Define `total-weight`.
c. Define a predicate `balanced?`.
d. How much changes if the constructors use `cons` instead of `list`?

**Answer**:

```scheme
; a. Selectors
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

; b. Total weight
(define (total-weight mobile)
  (define (branch-weight b)
    (let ((s (branch-structure b)))
      (if (pair? s)
        (total-weight s)
        s)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; c. Balanced?
(define (balanced? mobile)
  (define (branch-torque b)
    (* (branch-length b)
       (let ((s (branch-structure b)))
         (if (pair? s) (total-weight s) s))))
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (let ((ls (branch-structure (left-branch mobile)))
             (rs (branch-structure (right-branch mobile))))
         (and (if (pair? ls) (balanced? ls) #t)
              (if (pair? rs) (balanced? rs) #t)))))
```

d. If constructors use `cons`, only change `right-branch` to use `cdr` instead of `cadr`, and `branch-structure` to use `cdr` instead of `cadr`. All higher-level code remains unchanged — this is the power of data abstraction.

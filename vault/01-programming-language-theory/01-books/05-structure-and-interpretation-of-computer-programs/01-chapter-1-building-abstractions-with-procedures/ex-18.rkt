(define (add a b)
  (+ a b))

(define (double x)
  (* x 2))

(define (halve x)
  (if (= (remainder x 2) 0)
    (/ x 2)
    (/ (- x 1) 2)))

(define (mul a b)
  (define (even? k)
    (= (double (halve k)) k))
  (define (mul-iter s a b)          ; invariant: s + a * b = result
    (cond ((= b 0) s)
          ((even? b) (mul-iter s (double a) (halve b)))
          (else (mul-iter (add s a) (double a) (halve (add b -1))))))
  (mul-iter 0 a b))

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
  (define (mul-iter n)
    (cond ((= n 0) 0)
          ((even? n) (double (mul-iter (halve n))))
          (else (add a (double (mul-iter (halve (add n -1))))))))
  (mul-iter b))

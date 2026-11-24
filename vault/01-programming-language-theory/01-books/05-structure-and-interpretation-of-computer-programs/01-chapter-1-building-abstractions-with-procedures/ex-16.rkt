(define (expt b n)
  (define (even? k)
    (= (remainder k 2) 0))
  (define (square k)
    (* k k))
  (define (expt-iter n b a)                         ; a*b^n = result
    (cond ((= n 0) a)                               ; a = result
          ((even? n) (expt-iter (/ n 2)             ; a*(b^2)^(n/2) = result
                                (square b)
                                a))
          (else (expt-iter (/ (- n 1) 2)            ; (a*b)(b^2)^((n-1)/2) = result
                           (square b)
                           (* a b)))))
  (expt-iter n b 1))

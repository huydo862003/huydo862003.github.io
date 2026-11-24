(define (expt b n)
  (define (expt-iter i product)
    (if (= i 0)
      product
      (expt-iter (- i 1) (* product b))))
  (expt-iter n 1))

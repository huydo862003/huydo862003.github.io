(define (cont-frac n d k)
  (define (cont-frac-iter i result)  ; 1-based
    (if (<= i 0)
      result
      (cont-frac-iter (- i 1)
                      (/ (n i)
                         (+ (d i) result)))))
  (cont-frac-iter k 0))

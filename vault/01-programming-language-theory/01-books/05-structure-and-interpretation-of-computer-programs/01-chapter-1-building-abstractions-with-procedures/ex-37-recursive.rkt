(define (cont-frac n d k)
  (define (cont-frac-iter i)  ; 1-based
    (if (> i k)
      0
      (/ (n i) 
         (+ (d i)
            (cont-frac-iter (+ i 1))))))
  (cont-frac-iter 1))

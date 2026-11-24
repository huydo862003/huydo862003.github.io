(define (same-parity . l)
  (define (same-parity-iter l p)
    (cond ((null? l) #t)
          ((not (= (remainder (car l) 2) p)) #f)
          (same-parity-iter (cdr l) p)))
  (if (null? l)
    #t
    (same-parity-iter (cdr l)
                      (remainder (car l) 2))))

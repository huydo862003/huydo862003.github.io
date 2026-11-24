(define (reverse l)
  (define (reverse-iter l result)
    (if (null? l)
      result
      (reverse-iter (cdr l) (cons (car l) result))))
  (reverse-iter l null))

(define (last-pair l)
  (cond ((null? l) (error "`last-pair` cannot be called on an empty list"))
        ((null? (cdr l)) l)
        (else (last-pair (cdr l)))))

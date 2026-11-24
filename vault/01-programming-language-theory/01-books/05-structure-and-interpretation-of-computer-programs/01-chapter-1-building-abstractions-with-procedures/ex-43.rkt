(define (repeated f times)
  (if (= times 1)
    f
    (lambda (x) (compose f (repeated f (- times 1))))))

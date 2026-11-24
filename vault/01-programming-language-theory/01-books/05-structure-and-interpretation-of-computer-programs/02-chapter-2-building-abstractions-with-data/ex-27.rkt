(define (deep-reverse l)
  (define (reverse-iter l result)
    (if (null? l)
      result
      (let ((cur-e (if (pair? (car l))
                     (deep-reverse (car l))
                     (car l))))
        (reverse-iter (cdr l) (cons cur-e result)))))
  (reverse-iter l null))

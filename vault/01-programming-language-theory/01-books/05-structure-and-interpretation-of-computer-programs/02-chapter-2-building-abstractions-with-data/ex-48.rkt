(define (make-vect x y)
  (cons x y))

(define (make-segment v1 v2)
  (cons v1 v2))

(define (start-segment v)
  (car v))

(define (end-segment v)
  (cdr v))

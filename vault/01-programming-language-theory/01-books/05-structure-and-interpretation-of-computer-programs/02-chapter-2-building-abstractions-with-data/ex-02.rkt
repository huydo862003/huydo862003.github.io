(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment s e)
  (cons s e))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (midpoint-segment s)
  (let ((start-point (start-segment s))
        (end-point (end-segment s)))
    (make-point (average (x-point start-point) (x-point end-point))
                (average (y-point start-point) (y-point end-point)))))

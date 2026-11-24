(define (search f neg-point pos-point)
  (let ((mid-point (/ (+ pos-point neg-point) 2.0)))
    (if (close-enough? neg-point pos-point)
      mid-point
      (let ((test-value (f mid-point)))
        (cond ((> test-value 0) (search f neg-point mid-point))
              ((< test-value 0) (search f mid-point pos-point))
              (else mid-point))))))

(define (close-enough? a b)
  (< (abs (- a b)) 0.001))

(define (half-interval-method f a b)
  (let ((test-a (f a))
        (test-b (f b)))
    (cond ((and (> test-a 0) (< test-b 0))
           (search f b a))
          ((and (< test-a 0) (> test-b 0))
           (search f a b))
          (else
            (error "Values are not of opposite sign" a b)))))

(define (sqrt x)
  (define (sqrt-iter guess)
    (if (good-enough? guess)
      guess
      (sqrt-iter (improve guess))))
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) 0.0000001))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2.0)) ; `guess` better not be `0`
  (sqrt-iter 1.0))

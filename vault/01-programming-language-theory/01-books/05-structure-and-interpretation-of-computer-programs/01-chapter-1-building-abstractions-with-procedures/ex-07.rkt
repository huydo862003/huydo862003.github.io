(define (sqrt x)
  (define (sqrt-iter guess)
    (define next-guess (improve guess))
    (if (close-enough? guess next-guess)
      guess
      (sqrt-iter next-guess)))
  (define (close-enough? guess next-guess)
    (< (abs (- guess next-guess)) (/ guess 1000)))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2.0)) ; `guess` better not be `0`
  (sqrt-iter 1))

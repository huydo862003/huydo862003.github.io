; fast-exp
(define (expt b n)
  (define (even? k)
    (= (remainder k 2) 0))
  (define (square k)
    (* k k))
  (define (expt-iter i)
    (cond ((= i 0) 1)
          ((even? i) (square (expt-iter (/ i 2))))
          (else (* (square (expt-iter (/ (- i 1) 2)))
                   b))))
  (expt-iter n))

; pair
(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)))

(define (car z)
  (define (car-iter z result)
    (if (= (remainder z 2) 1)
      result
      (car-iter (/ z 2) (+ result 1))))
  (car-iter z 0))

(define (cdr z)
  (define (cdr-iter z result)
    (if (= (remainder z 3) 1)
      result
      (cdr-iter (/ z 3) (+ result 1))))
  (cdr-iter z 0))

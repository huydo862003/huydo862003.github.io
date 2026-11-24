(define (exponention? exp)
  (and (pair? exp) (eq (car exp) '**)))

(define (make-exponentiation b n)
  (list '** b n))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))

(define (deriv expr var)
    (cond ((number? expr) 0)
          ((variable? expr) (if (same-variable? expr var) 1
      0))
          ((sum? expr) (make-sum (deriv (adden expr) var
                                 (deriv (augend expr) var))))
          ((product? expr) (make-sum (make-product (multiplier expr) (deriv (multiplicand expr) var))
                                     (make-product (multiplicand expr) (deriv (multiplier expr) var))))
          ((exponentiation? expr) (make-product
                                    (make-product
                                      (make-exponentiation (base expr)
                                                           (- (exponent expr) 1))
                                      (exponent expr)
                                    (deriv (base expr) var)))
          (else (error "unknown expression type" expr))))


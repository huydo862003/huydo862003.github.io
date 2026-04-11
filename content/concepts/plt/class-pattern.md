---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Class pattern
description: "This pattern has many variants:"
journey: plt
status: learning
books:
  - chapter-4-objects
dependsOn: []
blocks: []
tags: []
keywords:
  - "lambda"
  - "members"
  - "class"
  - "pattern"
  - "amount"
  - "case"
  - "private"
  - "counter"
  - "scheme"
  - "reference"
  - "self"
---

This pattern has many variants:

- Basic class pattern
    
    ```scheme
    (define cls (constructor-params)
    	(lambda m
    		(case m
    			[(first) (lambda (x) x)]
    			[(second) (lambda (x) x)])))
    ```
    
    Pros: Simple.
    
    Cons:
    
    - Members cannot reference each other.
    - No private member.
- Class pattern with private members
    
    ```scheme
    (define cls (constructor-params)
    	(let ([x (...)]
    				[y (...)])
    		(lambda m
    			(case m
    				[(first) (lambda () x)]
    				[(second) (lambda () y)]))))
    ```
    
    Cons:
    
    - Private members cannot reference public members.
    - Public members cannot reference each other.
- Class pattern with private members that can reference public members
    
    ```scheme
    (define cls (constructor-params)
    	(let ([self 'dummy])
    		(let ([x (msg self 'first 1)])
    			(begin
    				(set self
    					(lambda m
    						(case m
    							[(first) (lambda (x) x)]
    							[(second) (lambda () x)])))
    				self))))
    ```
    
- Class pattern with private and static members
    
    ```scheme
    (define mk-o-static-fixed
      (let ([counter 0])
        (lambda (m)
          (case m
            [(count) (lambda () counter)]  ; accessible without instantiation
            [(new) (lambda (amount)
                     (begin
                       (set! counter (+ 1 counter))
                       (lambda (m)
                         (case m
                           [(inc) (lambda (n) (set! amount (+ amount n)))]
                           [(dec) (lambda (n) (set! amount (- amount n)))]
                           [(get) (lambda () amount)]
                           [(count) (lambda () counter)]))))]))))
    ```
    
    A class is simply an object.

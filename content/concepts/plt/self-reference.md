---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Self-reference"
journey: plt
status: mastered
tags: ["programming-paradigm"]
books: ["chapter-4-objects"]
dependsOn: []
blocks: []
---
:::key
(Programming paradigm) A technique in the Class pattern that allows members of a class to reference their owner objects.
:::

- Self-reference with mutation
    
    ```scheme
    (define msg (o m . args)
    	((o m) args))
    
    (define o-self!
    	(let ([self 'dummy])
    		(begin
    			(set! self
    				(lambda (m)
    					(case m
    						[(first) (lambda (x) (msg self 'second x))]
    						[(second) (lambda (x) x)])))
    			self)))
    ```
    
    Pros: Simple.
    
    Cons: The semantics must allow mutation.
    
- Self-reference without mutation
    
    ```scheme
    (define msg/self (o m . args)
    	((o m) o args))
    
    (define o-self!
    	(lambda (m)
    		(case m
    			[(first) (lambda (self x) (msg/self self 'second x))]
    			[(second) (lambda (self x) x)])))
    ```
    
    Pros: Simple & Do not require mutation.
    
    Cons: `self` must be passed correctly by the caller.
    
    According to Programming languages: Application and Interpretation, `self` should not be exposed to programmers but should only be done in desugaring.
    
- Self-reference with self-application
    
    ```scheme
    (define msg/self-app (o m . args)
    	(((o o) m) args))
    
    (define o-self!
    	(lambda (self)
    		(lambda (m)
    			(case m
    				[(first) (lambda (x) (msg/self-app self 'second x))]
    				[(second) (lambda (x) x)]))))
    ```
    
    This one actually allows Extensible/Open recursion using the Divergent/Big omega combinator.

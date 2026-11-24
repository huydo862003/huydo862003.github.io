---
_type: PltBook
_label: 'Chapter 3. Modularity, objects, and state'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Reading"
concepts:
  - fref("/01-programming-language-theory/02-concepts/state.td")
  - fref("/01-programming-language-theory/02-concepts/mutation.td")
  - fref("/01-programming-language-theory/02-concepts/environment.td")
  - fref("/01-programming-language-theory/02-concepts/local-variable.td")
  - fref("/01-programming-language-theory/02-concepts/message-passing.td")
---

We have seen how primitive procedures & primitive data are combined to construct compound entities, and how abstraction is vital to cope with the complexity of large systems. However: These tools are not sufficient for program design. Effective program synthesis requires *organizational principles* that guide us in *formulating the overall design of a program*.

One powerful design strategy: Base the structure of our programs on the structure of the system being modeled. For each object in the system, construct a corresponding computational object. For each system action, define a symbolic operation in our computational model.

Two world views:

- *Object-centric*: View a large system as a collection of distinct objects whose behaviors may change over time.
  - Challenges: How a computational object can change. How an object maintains its identity.
  - The substitution model of computation no longer works.
  - More mechanistic but less theoretically tractable *environment model* of computation.
  - The core issue is the need to grapple with time in the computational model.
- *Stream-centric*: Focus on the streams of information that flow in the system.
  - Decouple simulated time in our model from the order of the events that take place in the computer during evaluation.
  - Technique: *delayed evaluation*.

## Assignment and local state

- An object has a *state* if its behavior is influenced by its history.
- The state of an object is characterizable by one or more *state variables*, which maintain enough information about history to determine the object's current behavior.
- Objects may influence the state of others through *interactions* to couple the state variables of one object to those of other objects.
- This view is mostly useful when state variables can be grouped into *closely coupled subsystems* that are only *loosely coupled* to other subsystems.
- The programming language must provide an *assignment operator* to change the value associated with a name.

### Local state variables

```scheme
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
```

Special forms:

```scheme
(set! <name> <new-value>)
(begin <exp1> <exp2> ... <expk>)  ; evaluates in order, returns final value
```

Bank account object using message-passing style:

```scheme
(define (make-account balance)
  (define (withdraw amount) ...)
  (define (deposit amount) ...)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request" m))))
  dispatch)
```

### The benefits of introducing assignment

By introducing assignment and hiding state in local variables, we are able to structure systems in a more modular fashion.

Example: Monte Carlo method to estimate π using Cesaro's test.

Without assignment, the random number generator leaks out - `estimate-pi` has to supply an initial random number directly:

```scheme
; With local state - modular
(define rand (let ((x random-init))
               (lambda ()
                 (set! x (rand-update x))
                 x)))

; Without - random state leaks into estimate-pi
(define (estimate-pi trials)
  (sqrt (/ 6 (random-gcd-test trials random-init))))
```

-> By introducing assignment and the technique of hiding state in local variables, we are able to structure systems in a more modular fashion.

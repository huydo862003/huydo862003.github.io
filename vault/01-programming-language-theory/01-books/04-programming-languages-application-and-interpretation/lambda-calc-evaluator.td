---
_type: PltBook
_label: 'Project: Lambda calculus evaluator'
parent: fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/index.td")
journey: fref("/01-programming-language-theory/index.td")
status: "Finished"
---

A simple evaluator for an untyped lambda calculus extended with numbers and booleans.

Tasks:
- [x] Implement an AST for variables, lambda, application, booleans, numbers.
- [x] Implement a basic evaluator (substitution-based).
- [x] Extend the interpreter with `if` and numeric `+`.

### main.rkt

```scheme
#lang plai-typed

(define-type Exp
  [numE (n : number)]
  [boolE (b : boolean)]
  [varE (id : string)]
  [absE (param : string) (value : Exp)]
  [appE (abs : Exp) (arg : Exp)]
  [ifE (condE : Exp) (thenE : Exp) (elseE : Exp)]
  [plusE (left : Exp) (right : Exp)]
  [letE (id : string) (value : Exp) (exp : Exp)])

(define-type Value
  [numV (n : number)]
  [boolV (b : boolean)]
  [funcV (param : string) (value : Exp) (env : (hashof string Value))])

(define (isTruthy [v : Value]) : boolean
  (type-case Value v
    [numV (n) #t]
    [boolV (b) b]
    [funcV (param value env) #t]))

(define (Value->number [v : Value]) : number
  (type-case Value v
    [numV (n) n]
    [else (error 'Value->number "Expected a number")]))

(define (calc [e : Exp] [env : (hashof string Value)]) : Value
  (type-case Exp e
    [numE (n) (numV n)]
    [boolE (b) (boolV b)]
    [varE (id)
          (let ([val (hash-ref env id)])
            (type-case (optionof Value) val
              [none () (error 'var "Unbound variable")]
              [some (v) v]))]
    [absE (param value) (funcV param value env)]
    [appE (abs arg)
          (let ([absV (calc abs env)]
                [argV (calc arg env)])
            (type-case Value absV
              [funcV (param value env)
                     (calc value (hash-set env param argV))]
              [else (error 'app "The callee is not a function")]))]
    [ifE (condE thenE elseE)
         (let ([condV (calc condE env)])
           (if (isTruthy condV) (calc thenE env) (calc elseE env)))]
    [plusE (left right)
           (let ([leftV (Value->number (calc left env))]
                 [rightV (Value->number (calc right env))])
             (numV (+ leftV rightV)))]
    [letE (id value exp)
          (calc exp (hash-set env id (calc value env)))]))

;; Helper to run with empty environment
(define (run [e : Exp]) : Value
  (calc e (hash empty)))
```

### tests.rkt

```scheme
#lang plai-typed

(require "main.rkt")

(define mt-env (hash empty))

;; Test numbers and booleans
(test (calc (numE 42) mt-env) (numV 42))
(test (calc (boolE #t) mt-env) (boolV #t))
(test (calc (boolE #f) mt-env) (boolV #f))

;; Test identity function: (λx.x) 5 => 5
(test (run (appE (absE "x" (varE "x")) (numE 5)))
      (numV 5))

;; Test constant function: (λx.λy.x) 1 2 => 1
(test (run (appE (appE (absE "x" (absE "y" (varE "x")))
                       (numE 1))
                 (numE 2)))
      (numV 1))

;; Test let: let x = 10 in x => 10
(test (run (letE "x" (numE 10) (varE "x")))
      (numV 10))

;; Test nested let: let x = 5 in let y = x in y => 5
(test (run (letE "x" (numE 5)
                 (letE "y" (varE "x")
                       (varE "y"))))
      (numV 5))
```

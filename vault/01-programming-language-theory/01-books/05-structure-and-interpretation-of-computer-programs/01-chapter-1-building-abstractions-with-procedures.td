---
_type: PltBook
_label: 'Chapter 1. Building abstractions with procedures'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Reading"
concepts:
  - fref("/01-programming-language-theory/02-concepts/evaluation-strategy.td")
  - fref("/01-programming-language-theory/02-concepts/call-by-value.td")
  - fref("/01-programming-language-theory/02-concepts/call-by-name.td")
  - fref("/01-programming-language-theory/02-concepts/higher-order-function.td")
  - fref("/01-programming-language-theory/02-concepts/first-class.td")
  - fref("/01-programming-language-theory/02-concepts/closure.td")
  - fref("/01-programming-language-theory/02-concepts/fixed-point-combinator.td")
  - fref("/01-programming-language-theory/02-concepts/syntactic-sugar.td")
---

- Computational process: One that executes programs to answer questions/affect the world.
- Program: A pattern of rules to direct the _evolution_ of a process.
- Programming language: To express our procedural thoughts as a pattern of rules (program), just like mathematical notations aid in mathematical reasoning.

## Why Lisp?

- Lisp: LISt Processing.
- Conceived by John McCarthy.
- Invented in the late 1950s as a formalism for reasoning about the use of recursion equations as a model for computation.
- Designed to provide symbol manipulating capabilities for programming problems such as symbolic differentiation and integration of algebraic expressions. For this purpose, it includes new data objects known as _atoms_ and _lists_.
- Philosophy: Lisp was not the product of a concerted design effort. It evolved _informally_ in an experimental manner in response to users' needs and to pragmatic implementation considerations. The community of Lisp users has traditionally resisted attempts to promote any official definition of the language. Due to this informality, Lisp is by now a family of dialects.
- Lisp was very inefficient for numerical computation due to its emphasis on symbol manipulation. This has been mitigated over the years, though Lisp still hasn't overcome its old reputation as hopelessly inefficient.
- **Most significant feature**: Its descriptions of processes, called procedures, can be represented as Lisp data. Lisp is an excellent language for writing programs that must manipulate other programs as data.

## The elements of programming

A programming language should serve as a framework within which we organize our ideas about processes - not just a means for instructing a computer. We should view language features from a _pragmatic_ viewpoint.

Every powerful language has 3 mechanisms for accomplishing this:

- *Primitive expressions* - the simplest entities the language is concerned with.
- *Means of combination* - by which compound elements are built from simpler ones.
- *Means of abstraction* - by which compound elements can be named and manipulated as units.

Two kinds of elements: *procedures* and *data*.

- Data: Stuff we manipulate.
- Procedures: Descriptions of the rules for manipulating the data.

### Expressions

Lisp uses a prefix notation called S-expression. Lisp obeys the convention that every expression has a value. A _special form_ breaks out of this convention.

```scheme
(/ 10 5)
(+ 2.7 10)
(* (- 2 3) (+ 3 5))
```

- Combination: Expression formed by delimiting a list of expressions within parentheses to denote procedure application.
- Operator: Leftmost element in the list.
- Operand: The remaining elements.

### Naming and the environment

An important aspect of a programming language is using _names_ to refer to _computational objects_. The _name_ identifies a _variable_ whose _value_ is the object.

In Scheme, `define` is a special form for naming things:

```scheme
(define size 2)
```

Naming is the simplest means of abstraction. The interpreter maintains an _environment_ - memory that keeps track of name-object pairs.

### Evaluating combinations

To evaluate a combination:

1. Evaluate the subexpressions of the combination. The operator should evaluate to a procedure; the others evaluate to values of arguments.
2. Apply the procedure to the arguments.

The evaluation rule is recursive in nature. This yields _tree accumulation_.

- Syntactic sugar: Special syntax forms that are convenient alternative _surface_ structures for things that can be written in _more uniform_ ways.

### Compound procedures

Procedure definition is another abstraction technique:

```scheme
(define (<name> <formal parameters>)
  <body>)
```

Note the difference:

```scheme
(define x1 2)       ; x1 is the name for the value 2
(define (x2) 2)     ; x2 is a procedure that returns 2 when called as (x2)
```

### The substitution model

*Substitution model*: To apply a compound procedure to its argument, evaluate the procedure body with each formal parameter replaced by the corresponding argument.

The substitution model is just a mental model for visualizing process application - not an enforcement of how the interpreter works.

### Applicative order vs normal order

- *Normal-order evaluation*: "Fully expand and then reduce" - arguments are not evaluated immediately but are substituted into a procedure body first.
- *Applicative-order evaluation*: Evaluate the arguments and then apply (also known as call-by-value).

For procedures that can be modeled using the substitution model and yield legitimate values, both produce the same result.

Lisp uses applicative-order evaluation because:
- Additional efficiency.
- Normal-order evaluation becomes unwieldy outside the realm of procedures that can be modeled by substitution.

**Why `if` must be a special form** (not a regular procedure): If `if` were a regular procedure, applicative-order evaluation would evaluate both branches before applying it - causing infinite recursion in procedures like `sqrt-iter` where the base case would never stop the recursive branch from being evaluated. Special forms like `if` short-circuit: the predicate is evaluated first, and only the relevant branch is evaluated.

## Procedures and the processes they generate

- Procedure = pattern for the _local evolution_ of a computational process.
- We want to reason about the _global behavior_ of a procedure.

### Linear recursion and iteration

A factorial function that generates a _linear recursive_ process:

```scheme
(define (factorial n)
  (if (= n 0)
    1
    (* n (factorial (- n 1)))))
```

This generates a shape of expansion (builds up a chain of deferred operations) followed by contraction. There is hidden information inside the interpreter that keeps track of where we are in the process. The amount of information needed grows linearly with `n`. -> A _linear recursive process_.

A factorial function that generates a _linear iterative_ process:

```scheme
(define (factorial n)
  (define (iter i product)
    (if (= i 0)
      product
      (iter (- i 1) (* product i))))
  (iter n 1))
```

This does not grow or shrink. An iterative process's state can be summarized by a fixed number of _state variables_. The number of steps grows linearly with `n`. -> A _linear iterative process_.

A recursive procedure can generate an iterative process.

- C, Ada, Pascal must use looping constructs to describe iterative processes; recursive procedures there always consume resources growing linearly with the number of calls.
- Scheme will execute an iterative process in constant space even if described by a recursive procedure. -> _Tail-recursive_ implementation.
- In a tail-recursive implementation, special iteration constructs can be considered syntactic sugar.

### Tree recursion

A tree-recursive Fibonacci:

```scheme
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

- Steps grow exponentially with input (total number of tree nodes).
- Space grows linearly with the depth of the tree.

An iterative Fibonacci:

```scheme
(define (fib n)
  (define (fib-iter rounds fib-i-2 fib-i-1)
    (if (= rounds 0)
      fib-i-1
      (fib-iter (- rounds 1) fib-i-1 (+ fib-i-1 fib-i-2))))
  (fib-iter n 1 0))
```

Tree-recursive: Higher inefficiency, but easy to specify & understand. One approach to get the best of both worlds is _tabulation_ or _memoization_.

### Orders of growth

- Let `n` be a parameter that measures the size of the problem & `R(n)` be the amount of resources the process requires. `R(n) = Θ(f(n))` if `k1 f(n) <= R(n) <= k2 f(n)` for any sufficiently large `n`.

### Exponentiation

Naive idea: $b^n = b \cdot b^{n-1}$, $b^0 = 1$.

- Linear recursive: `Θ(n)` steps and `Θ(n)` space.
- Linear iterative: `Θ(n)` steps and `Θ(1)` space.

Better idea using successive squaring:

$$b^{n} = (b^{n/2})^2 \text{ if n is even}, \quad b^{n} = b \cdot b^{n-1} \text{ if n is odd}$$

Grows logarithmically with `n` in both space and number of steps.

Remark from exercises 1.16-1.18, two thought frameworks:

- *Recursive version*: Come up with an induction formula and directly translate it.
- *Iterative version*: Try to think of an invariant.

### Greatest common divisors

Euclid's algorithm: If `r <- a mod b` then `GCD(a, b) = GCD(b, r)`. According to Lamé's theorem, the order of growth is `Θ(log n)`.

### Testing for primality

**Searching for divisors**: Search from `1` to `sqrt(n)`. An iterative process with `Θ(sqrt(n))` order of growth.

**The Fermat test**: A `Θ(log n)` primality test, based on Fermat's Little Theorem:

> If `n` is a prime number and `a` is any positive integer less than `n`, then `a` raised to the nth power is congruent to `a` modulo `n`.

Algorithm: Given `n`, repeatedly pick a random number `a < n`. Compute the remainder of `a^n modulo n`. If not equal to `a`, then `n` is certainly not prime. If equal, there is a high chance `n` is prime. -> By trying more values of `a`, we can be more confident.

The Fermat test can be fooled by Carmichael numbers (non-prime numbers that satisfy the relation for all `a < n`). Variations of the Fermat test exist that cannot be fooled.

- _Probabilistic algorithm_: One that the chance of error can be proved to become arbitrarily small.

## Formulating abstractions with higher-order procedures

Procedures are abstractions that describe operations on parameters independent from particular arguments. Without procedures, we're forced to always work with the primitive operations of a language.

Higher-order procedures = procedures that manipulate other procedures. They can express a programming pattern.

### Procedures as arguments

Consider three patterns sharing a common structure:

```scheme
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))
```

This allows expressing integrals:

```scheme
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f a add-dx b) dx))
```

### Constructing procedures using `lambda`

The `lambda` special form:

```scheme
(lambda (<formal-parameters>) <body>)
```

#### Using `let` to create local variables

```scheme
(let ((<var1> <exp1>)
      (<var2> <exp2>)
      ...
      (<varn> <expn>))
  <body>)
```

The `let` expression is syntactic sugar for the underlying `lambda` application. Implications:

- The scope of a variable specified by a `let` expression is the body of the `let`.
- The variables' values are computed outside the `let`.

### Procedures as general methods

**Half-interval method**: Technique for finding roots of $f(x) = 0$ where $f$ is continuous. If $f(a) < 0 < f(b)$, narrow down the range by taking the midpoint. Complexity: `Θ(log(L/T))`.

**Fixed points of functions**: A number `x` is a fixed point of `f` if $f(x) = x$. Find by beginning with an initial guess and applying `f` repeatedly.

We can think of finding square roots as finding fixed points: the square root of `x` is the fixed point of $f(t) = x/t$.

However, $y \to x/y$ does not converge. **Average damping** aids convergence: Instead of `y -> x/y`, take `y -> (y + x/y) / 2`.

### Procedures as returned values

Average damping expressed as a procedure:

```scheme
(define (average-damp f)
  (lambda (x) (average x (f x))))
```

Using `average-damp`, `sqrt` becomes:

```scheme
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
```

Three ideas made clear: fixed-point search, average damping, and the function $y \to x/y$.

**General Newton's method**: To estimate the solution to `g(x) = 0`, estimate the fixed point of $x - g(x)/Dg(x)$.

```scheme
(define (deriv g)
  (define dx 0.00001)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newtons-method g guess)
  (define (transformed-g x) (- x (/ (g x) ((deriv g) x))))
  (fixed-point (average-damp transformed-g) guess))
```

### Abstractions and first-class procedures

Programming languages impose restrictions on the ways in which computational elements can be manipulated. Elements with the fewest restrictions are said to have **first-class status**.

"Rights and privileges" of first-class elements:

- They may be named by variables.
- They may be passed as arguments to procedures.
- They may be returned as the results of procedures.
- They may be included in data structures.

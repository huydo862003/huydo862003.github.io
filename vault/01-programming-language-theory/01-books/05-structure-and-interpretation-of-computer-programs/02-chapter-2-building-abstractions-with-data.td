---
_type: PltBook
_label: 'Chapter 2. Building abstractions with data'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Reading"
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-data-type.td")
  - fref("/01-programming-language-theory/02-concepts/closure.td")
  - fref("/01-programming-language-theory/02-concepts/message-passing.td")
  - fref("/01-programming-language-theory/02-concepts/s-expression-symbolic-expression.td")
---

The ability to construct compound data objects enables us to deal with data at a higher conceptual level than that of the primitive data objects of the language.

The use of *compound data* increases the modularity of programs:

- We can treat a rational number as a whole instead of parts.
- The part of our program that deals with rational numbers does not have to care about how they are represented.

*Data abstraction*: The general technique of isolating the parts of a program that deal with *how data objects are represented* from the parts that deal with *how data objects are used*.

Key ideas:

- *Data abstraction* enables suitable *abstraction barriers* between different parts of a program.
- Procedures alone can be used to form compound data, without any special "data" operations whatsoever. -> Blurs the distinction between data and procedures.
- *Closure property*: The glue we use for combining data objects should allow us to combine compound data objects as well.
- *Conventional interfaces*: A compound data object that serves as an interface allowing multiple program modules to combine in mix-and-match ways.
- *Generic operations*: Operations that must handle many different types of data/representations.
- *Data-directed programming*: Allow individual data representations to be designed in isolation and combined *additively* (without modification).

## Introduction to data abstraction

Basic ideas of *data abstraction*:

- Structure programs that use compound data objects so that they operate on "abstract data" - programs should make no assumptions about the data.
- A *concrete data representation* is defined independently of the programs that use the data.
- The interface between these two parts will be a set of procedures called *selectors* and *constructors*.

## Pairs

Operations on pairs:

```scheme
(cons <x> <y>)   ; construct a pair
(car <p>)        ; extract the first element of a pair
(cdr <p>)        ; extract the second element of a pair
```

A pair data object can be given a name and manipulated like a primitive data object. The *closure property* means pairs can be constructed from elements which are pairs themselves.

### Church numerals (exercise 2.6)

In a language that can manipulate procedures, we can get by without numbers by implementing `0` and `add-1` as:

```scheme
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

This representation is known as **Church numerals**, after Alonzo Church, the logician who invented the λ-calculus. The number `n` is represented as the application of `f` exactly `n` times to `x`:

```scheme
; one:
(lambda (f) (lambda (x) (f x)))
; two:
(lambda (f) (lambda (x) (f (f x))))
```

Direct definition of `+`:

```scheme
(define (+ n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))
```

This demonstrates that data and procedures are deeply interchangeable: numbers themselves can be encoded as higher-order functions.

### What is meant by data?

*Data* = A collection of constructors and selectors + a collection of conditions they must satisfy.

An implementation of `pair` using procedures alone (procedural representation / message passing):

```scheme
(define (cons first second)
  (define (dispatch m)
    (cond ((= m 0) first)
          ((= m 1) second)
          (else (error "Argument not 0 or 1" m))))
  dispatch)

(define (car z) (z 0))
(define (cdr z) (z 1))
```

## Abstraction barriers

The underlying idea of data abstraction:
- Identify a basic set of operations to work on the data objects.
- Use only this set of operations on the data objects.
- Independent of the underlying representations.

```
-------[ Programs that use rational numbers ]-------
        Rational numbers in problem domain
--------[ add-rat    sub-rat   ... ]----------------
    Rational numbers as numerators and denominators
--------[ make-rat   numer   denom ]----------------
         Rational numbers as pairs
-------------------[ cons car cdr ]-----------------
      However pairs are implemented
```

Advantages: Makes programs easier to maintain and modify.

## Hierarchical data and the closure property

*Closure property*: The property of a data combination operation where the result of such operation can themselves be combined using that same operation.

-> Permits us to create *hierarchical* structures - structures made of parts, which are made up of parts, and so on.

### Sequences

List: Nested `cons`es. The `list` primitive:

```scheme
(list <a1> <a2> ... <an>)
```

#### Mapping over lists

```scheme
(define (map proc items)
  (if (null? items)
    null
    (cons (proc (car items))
          (map proc (cdr items)))))
```

Map is a very important construct - it captures a common pattern and provides a higher level of abstraction in dealing with lists.

## Sequences as conventional interfaces

*Conventional interfaces* is a powerful design principle. Consider this common structure:

- Enumerate something (leaves of a tree or values in a range).
- Filter them.
- Transform.
- Accumulate results.

-> Analogy: Signal-flow.

### Sequence operations

Key: Hoist the "signals" as the main entities. Signals are sequences of values represented as lists.

Operations:

- `map`: Apply transformation to each element.
- `filter`: Select elements satisfying a predicate.
- `accumulate`: Reduce a list using a binary operation and initial value.
- Enumeration: `enumerate-interval`, `enumerate-tree`.

### Nested mappings

`flatmap`: Abstract the combination of mapping and accumulating with `append`.

```scheme
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))
```

### Example: A picture language

A simple language for drawing pictures, showcasing data abstraction, closure, and higher-order procedures.

- Primitive data: *painter* - a procedure that draws an image shifted and scaled to fit within a designated parallelogram-shaped frame.
- Means of combination: `beside`, `below`, `flip-vert`, `flip-horiz` - painters are closed under these operations.
- Means of abstraction: Scheme procedures.

A *frame* is described by three vectors: an *origin vector* and two *edge vectors*. Images are specified in the unit square and mapped to frames via the *frame coordinate map*:

$$\text{Origin}(\text{Frame}) + x \cdot \text{Edge}_1(\text{Frame}) + y \cdot \text{Edge}_2(\text{Frame})$$

A painter is represented as a procedure that takes a frame as an argument and draws its image to fit that frame. This enables painters to be transformed and combined by transforming their frames.

#### Stratified design

*Stratified design*: A complex system should be structured as a sequence of levels, each described using a sequence of languages. A level is used as the primitive for the next level.

- Pros: Makes programs *robust* - small changes in a specification require correspondingly small changes in the program.
- Critical ideas:
  - Fundamental data abstractions are specified using procedural representations.
  - The means of combination satisfy the closure property.
  - Tools for abstracting procedures can combine painters in more abstract ways than primitive combinators.

## Symbolic data

### Quotation

The reason we have to quote symbols is to not confuse them with identifiers:

- `(list a b)`: Construct a list of the *values* of `a` and `b`.
- `(list 'a 'b)`: Construct a list of `a` and `b` themselves.

Quotation is powerful: it facilitates building expressions that manipulate other expressions. It also makes it harder to reason about: it destroys the notion that *equals can be substituted for equals*.

### Example: Symbolic differentiation

This is one of the original motivations for Lisp - a symbolic manipulation language. Using wishful thinking / data abstraction:

1. Define a differentiation algorithm that operates on abstract objects such as "sums", "products" and "variables".
2. Define the representation for these abstract objects.

Reduction rules:
- $\frac{dc}{dx} = 0$ (c is a constant or variable different from x)
- $\frac{dx}{dx} = 1$
- $\frac{d(u+v)}{dx} = \frac{du}{dx} + \frac{dv}{dx}$
- $\frac{d(uv)}{dx} = u\frac{dv}{dx} + v\frac{du}{dx}$

### Example: Representing sets

Operations: `union-set`, `intersection-set`, `element-of-set?`, `adjoin-set`.

Three representations with different tradeoffs:

**Sets as unordered lists**: Simple. `element-of-set?`: Θ(n), `intersection-set`: Θ(n²), `union-set`: Θ(n²).

**Sets as ordered lists**: Speed up by ordering elements. `intersection-set`: Θ(n), `union-set`: Θ(n).

**Sets as binary trees**: Binary search tree. If balanced, `element-of-set?`: Θ(log n), `adjoin-set`: Θ(log n).

### Example: Huffman encoding trees

- Fixed-length code: With `b` bits, we can represent `2^b` symbols.
- Variable-length code (e.g. Morse code): Different symbols may have different number of bits. If more frequent symbols are assigned shorter codes, we can encode data more efficiently.
- *Prefix code*: No complete code for any symbol is a prefix of another code for another symbol.
- *Huffman encoding*: A variable-length prefix code that takes advantage of the relative frequencies of symbols.

Huffman tree generation algorithm:

1. Start with a set of leaf nodes weighted by frequency.
2. Each time, take out the two nodes with the lowest weights, merge them into a non-leaf node with the sum of the two weights.
3. Repeat until one node remains - the root.

## Multiple representations for abstract data

There might be more than one useful representation for a data object. We need abstraction barriers that isolate different design choices and permit them to coexist. Large programs are often created by combining pre-existing modules - conventions are needed to permit *additive* incorporation.

*Generic procedures*: Procedures that can operate on data that may be represented in more than one way.

### Tagged data

*Principle of least commitment*: Defer the choice of a concrete representation to the last possible moment.

We can carry this further: Maintain ambiguity of representation even after we have designed the selectors and constructors. -> Use *type tags* to distinguish representations.

### Data-directed programming and additivity

*Dispatching on type*: Checking the type of a datum and calling an appropriate procedure.

- Pros: Modularity.
- Cons: Non-additivity. Generic interface procedures must know about all different representations. Adding new representations requires modifying all generic interface procedures. Name collision.

Three strategies for the operation-and-type table:

| Strategy | Adding new types | Adding new operations |
| --- | --- | --- |
| Dispatching on type | Requires modifying all existing operations | Easy |
| Message passing | Easy | Requires modifying all existing types |
| Data-directed programming | Easy | Easy |

*Data-directed programming*: Design programs to work with an operation-and-type table directly. Adding a new representation package only requires adding new entries to the table.

```scheme
(put <op> <type> <item>)   ; install in table
(get <op> <type>)          ; lookup in table
```

The generic interface procedure:

```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types"
                 (list op type-tags))))))
```

### Message passing

*Message passing*: Decomposes the operation-and-type table into columns. The data representation is a closure that pattern-matches on operation names:

```scheme
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else (error "Unknown op" op))))
  dispatch)
```

The corresponding `apply-generic`:

```scheme
(define (apply-generic op arg) (arg op))
```

## Systems with generic operations

*Coercion*: When different data types are related, objects of one type may be viewed as being of another type. -> Define *coercion procedures* that transform an object of one type into an equivalent object of another type.

### Hierarchies of types

A *tower* of types (e.g. integer -> rational -> real -> complex) allows automatic coercion by defining `raise` procedures. Each type inherits all operations defined on a supertype.

Inadequacies: Not all hierarchies are towers. Dealing with large numbers of interrelated types while preserving modularity is very difficult.

> "A variety of inadequate ontological theories have been embodied in a plethora of correspondingly inadequate programming languages. For example, much of the complexity of object-oriented programming languages—and the subtle and confusing differences among contemporary object-oriented languages—centers on the treatment of generic operations on interrelated types."

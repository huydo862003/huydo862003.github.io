---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 4. objects
author: Shriram Krishnamurthi
date: ""
journey: plt
tags: []
concepts:
  - object
  - object-closure
  - method-function
  - object-lambda-expression
  - object-pattern
  - class-pattern
  - prototype-class
  - mixin
  - trait
  - trait-mixin
parent: programming-languages-application-and-interpretation
children: []
---

# What is an object?

- Object:
    - A value that maps names to stuff (either other values or "methods").
    - A generalization of Closures.
- From a minimalist perspective, Methods are just Functions.
- An Object member refers to a generic entry in an object (when we don't distinguish between fields and methods).

**Basic implementation:**

```racket
(define o
  (lambda (m)
    (case m
      [(add1) (lambda (x) (+ x 1))]
      [(sub1) (lambda (x) (- x 1))])))
```

- The object dispatches on a given name using `case`.
- Basic objects are a generalization of lambda to have **multiple entry-points**.
- Conversely, a lambda is an object with only one entry-point (doesn't need a method name)

**Method invocation helper:**

```racket
(define (msg o m . a)
  (apply (o m) a))

(test (msg o 'add1 5) 6)
```

**Important:** Nothing precludes writing an arbitrary expression for the member name:

```racket
(test (msg o (first '(add1)) 5) 6)  ; computed member name
```

- This is unlike many languages (e.g., Java) which force literal member names.
- **Pitfall with desugaring:** The target language may allow expressions that have no counterpart in the source language.

# The object pattern

The Object pattern is code that looks like:

```racket
(lambda (m)
  (case m
    … dispatch on each of the members …))
```

# Constructors

- A Constructor is a function invoked at object construction time.
- Turn an object from a literal into a function that takes constructor parameters.

```racket
(define (o-constr x)
  (lambda (m)
    (case m
      [(addX) (lambda (y) (+ x y))])))

(test (msg (o-constr 5) 'addX 3) 8)
(test (msg (o-constr 2) 'addX 3) 5)
```

- Two invocations of constructors don't interfere (as expected from Lexical/Static scope).

# The class pattern

- Adding constructors shifts us from objects to **functions-that-make-objects**.
- What makes objects? Classes! And classes typically have Constructors.
- The Class pattern at its simplest:
    
    ```racket
    (define (class constructor-params)
      … the object pattern …)
    ```
    

# State

- Many believe objects primarily exist to **encapsulate State**.
- If desugaring to a language with variables, multiple methods can mutate common state.

```racket
(define (mk-o-state count)
  (lambda (m)
    (case m
      [(inc) (lambda () (set! count (+ count 1)))]
      [(dec) (lambda () (set! count (- count 1)))]
      [(get) (lambda () count)])))
```

**Testing state isolation:**

```racket
(test (let ([o1 (mk-o-state 3)]
            [o2 (mk-o-state 3)])
        (begin (msg o1 'inc)
               (msg o1 'inc)
               (+ (msg o1 'get)
                  (msg o2 'get))))
      (+ 5 3))  ; mutating o1 doesn't affect o2
```

**Alan Kay's perspective:**

> The inventor of Smalltalk disagrees that objects are primarily for state. He said the small-scale motivation for OOP was "to find a more flexible version of assignment, and then to try to eliminate it altogether." He adds that much "object-oriented programming" today is "simply old style programming with fancier constructs."
> 

# Private members

- **Private members** are visible only inside the object, not outside.
- In Java, the keyword `private` designates them (both fields and methods).
- Used to control data that should not be accessed externally (e.g., a private cryptographic key).

**Important caveat:**

- In Java, other instances of the same class type can access "private" members. Otherwise, you couldn't implement an **Abstract Data Type**.
- Note: classes are not Abstract Data Types!

**Pitfall:**

- Private members alone are not enough. A private member might refer to a cryptographic key, but there may be other **aliases** to it that are not private and could leak it.
- Private members must often be used with **aliasing reasoning**.

**Implementation using lexical scope:**

```racket
(define (mk-o-state/priv init)
  (let ([count init])
    (lambda (m)
      (case m
        [(inc) (lambda () (set! count (+ count 1)))]
        [(dec) (lambda () (set! count (- count 1)))]
        [(get) (lambda () count)]))))
```

- `count` is hidden from the outside world.
- Only members that `case` handles are visible.
- No special keyword needed; **lexical scoping** handles visibility.

**Question**. If we were to directly desugar to the code above, public members can clearly refer to private ones; but can private members refer to public ones?

Yes, by passing `self` to the private scope:

```racket
(define (mk-o-priv-refs-pub init)
  (let ([self 'dummy])
    (let ([private-helper (lambda () (msg self 'get))])  ; private refs public
      (begin
        (set! self
          (lambda (m)
            (case m
              [(get) (lambda () init)])))
        self))))
```

# Refined class pattern

```racket
(define (class-w/-private constructor-params)
  (let ([private-vars …] …)
    … the object pattern …))
```

Or equivalently:

```racket
(define class-w/-private
  (lambda (constructor-params)
    (let ([private-vars …] …)
      … the object pattern …)))
```

# Static members

- **Static members** are common to all instances of the same type of object.
- A lexically-scoped identifier (making it private) that lives **outside the constructor** (making it common to all uses).

**First solution:**

```racket
(define mk-o-static
  (let ([counter 0])
    (lambda (amount)
      (begin
        (set! counter (+ 1 counter))
        (lambda (m)
          (case m
            [(inc) (lambda (n) (set! amount (+ amount n)))]
            [(dec) (lambda (n) (set! amount (- amount n)))]
            [(get) (lambda () amount)]
            [(count) (lambda () counter)]))))))

(test (let ([o (mk-o-static 1000)])
        (msg o 'count))
      1)
(test (let ([o (mk-o-static 0)])
        (msg o 'count))
      2)  ; counter persists across instances

```

**Issue:** Statics as defined here are accessed through objects. But statics belong to the class, not objects, and should be accessible through the class itself (even when no instances exist).

**Solution - statics accessible through class:**

```racket
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

; Can access count when still 0:
(test (msg mk-o-static-fixed 'count) 0)
```

# Re-refined class pattern

```racket
(define class-w/-private&static
  (let ([static-vars …] …)
    (lambda (constructor-params)
      (let ([private-vars …] …)
        … the object pattern …))))
```

Or: `(let ([static-vars …] …) … the class-w/-private pattern …)`.

# Self-reference

- Until now, members have been independent of each other.
- A true object system needs a way for methods to reference the object they're part of.
- Many systems provide **`self`** or **`this`** automatically.

## Self-reference using mutation

```racket
(define o-self!
  (let ([self 'dummy])
    (begin
      (set! self
        (lambda (m)
          (case m
            [(first) (lambda (x) (msg self 'second (+ x 1)))]
            [(second) (lambda (x) (+ x 1))])))
      self)))

(test (msg o-self! 'first 5) 7)
```

- Bind a variable to a **dummy value** (so it's visible).
- Then mutate it to have its true recursive definition.
- This pattern is at the heart of **`letrec`** or other recursive let constructs.

## Self-reference without mutation

```racket
(define o-self-no!
  (lambda (m)
    (case m
      [(first) (lambda (self x) (msg/self self 'second (+ x 1)))]
      [(second) (lambda (self x) (+ x 1))])))

(define (msg/self o m . a)
  (apply (o m) o a))

(test (msg/self o-self-no! 'first 5) 7)
```

- Each method takes `self` as an argument.
- Method invocation passes the object as a parameter to the method.
- **Key distinction:** We did not do this when invoking a function! This distinguishes **functions and methods**.
- **Pitfall:** Dangerous because we can pass a different object as "self".
- Should only be done in desugaring, not exposed to developers.
- Unfortunately, **Python exposes exactly this** in its surface syntax.

# Dynamic dispatch

- Ability to invoke a method without the caller knowing which object will handle it.
- In traditional functions, we must implement a conditional (type-case) that exhaustively lists and selects between different kinds of objects.
- If definitions grow to include new kinds, each code fragment must be modified.

**Dynamic dispatch solves this** by making the conditional branch disappear from the user's program and be handled by method selection code in the language.

- Key feature: an **extensible conditional**.
- This is one dimension of the **extensibility that objects provide**.

**Example with binary tree:**

```racket
(define (mt)
  (let ([self 'dummy])
    (begin
      (set! self
        (lambda (m)
          (case m
            [(sum) (lambda () 0)])))
      self)))

(define (node v l r)
  (let ([self 'dummy])
    (begin
      (set! self
        (lambda (m)
          (case m
            [(sum) (lambda () (+ v
                                 (msg l 'sum)
                                 (msg r 'sum)))])))
      self)))

(define a-tree
  (node 10
    (node 5 (mt) (mt))
    (node 15 (node 6 (mt) (mt)) (mt))))

(test (msg a-tree 'sum) (+ 10 5 15 6))

```

- No checking whether recipient is `mt` or `node`.
- The language's runtime extracts the recipient's method and invokes it.
- **The conditional missing from user's program, handled automatically by the language, is the essence of dynamic dispatch**.
- We didn't have to change our pattern to add dynamic dispatch; it followed from the design.

**Dual advantage:** While objects provide black-box extensibility (add new types without modifying code), functions have a dual advantage. Many OO programmers use the **Visitor pattern** to make code look more function-based.

# Member name design space

Two questions:

1. Is the set of member names **statically fixed**, or can it be changed **dynamically**?
2. Is the member being accessed **statically fixed**, or can it be **computed dynamically**?

|  | Name is static | Name is computed |
| --- | --- | --- |
| **Fixed set of members** | Base Java | Java with reflection |
| **Variable set of members** | Difficult to envision (what use would it be?) | Most "scripting" languages |
- If member access must be fixed in source, the set of names is pre-decided, so dynamically changing members doesn't make sense.
- The lower-right quadrant uses **hash-tables** to represent objects.
- The name is simply the index into the hash-table.
- Some languages conflate objects with **dictionaries and even arrays**.
- Creates significant difficulty for **type-checking**.

# What goes in else? (Inheritance)

- An `else` clause can "chain" control to another, **parent object**.
- This is called **inheritance**:

```racket
(case m
  ...
  [else (parent-object m)])
```

- This application effectively searches for the member in the parent (and recursively in its parents).
- If found, it returns through this chain to the original `msg` call.
- If none found, the final object signals "message not found" error.

# Extending classes

**Java's hidden behavior:** When you call `super(x, y)`, hidden in the constructor is creation of a parent instance. Java expects `super` to be the **first statement** in the subclass constructor.

**Revealing hidden parent objects in Java:**

```java
class Pt2 {
    public int x;
    Pt2(int x, int y) { this.x = x - 3; }
}

class Pt3 extends Pt2 {
    public int x;
    Pt3(int x, int y, int z) {
        super(x, y);
        this.x = x + 7;
    }
}

// In main:
Pt3 p3345 = new Pt3(3, 4, 5);
System.out.println(p3345.x);         // 10 (3+7)
System.out.println(((Pt2)p3345).x);  // 0  (3-3) - the hidden Pt2!
```

- **Casting reveals the hidden parent objects**.

**Implementation pattern:**

- The parent parameter should be the **parent object's maker**, not the parent object itself.
- This lets the extension invoke the parent constructor.

```racket
(define (node/size parent-maker v l r)
  (let ([parent-object (parent-maker v l r)]
        [self 'dummy])
    (begin
      (set! self
        (lambda (m)
          (case m
            [(size) (lambda () (+ 1
                                  (msg l 'size)
                                  (msg r 'size)))]
            [else (parent-object m)])))
      self)))

(define (mt/size parent-maker)
  (let ([parent-object (parent-maker)]
        [self 'dummy])
    (begin
      (set! self
        (lambda (m)
          (case m
            [(size) (lambda () 0)]
            [else (parent-object m)])))
      self)))

(define a-tree/size
  (node/size node
    10
    (node/size node 5 (mt/size mt) (mt/size mt))
    (node/size node 15
      (node/size node 6 (mt/size mt) (mt/size mt))
      (mt/size mt))))

(test (msg a-tree/size 'sum) (+ 10 5 15 6))  ; inherited method
(test (msg a-tree/size 'size) 4)              ; new method
```

**Note:** The repeated pattern `(mt/size mt)` is precisely what Java's `extends` clause does-binding the extension to its parent.

**Using self-application instead of mutation:**

```racket
(define (node/size-no-mut parent-maker v l r)
  (let ([parent-object (parent-maker v l r)])
    (lambda (self)
      (lambda (m)
        (case m
          [(size) (lambda () (+ 1
                                ((((l self) 'size)))
                                ((((r self) 'size)))))]
          [else (parent-object m)])))))
```

**What is a class extension?** Each function parameterized over a parent. Corresponds to:

```java
class NodeSize extends Node { ... }
```

**Java's member visibility:**

- Only **one method** of a given name/signature remains (the most refined).
- **Every field** remains and can be accessed by casting.
- Fields staying separate makes sense (each has invariants).
- Many scripting languages make **all methods** available, not just the lowest in hierarchy.

**Open recursion problem:** The self-reference is to the same syntactic object, but it needs to refer to the **most-refined object**. This is called **open recursion**.

**Solution for open recursion (self-application method):**

```racket
(define (node/size-open parent-maker v l r)
  (let ([parent-object (parent-maker v l r)])
    (lambda (self)  ; self will be the most-refined object
      (lambda (m)
        (case m
          [(size) (lambda () (+ 1
                                (msg (self self) 'size)  ; uses most-refined
                                (msg (self self) 'size)))]
          [else ((parent-object self) m)])))))
```

This demonstrates the other form of extensibility from objects: **extensible recursion**.

# Prototypes

- Instead of parent as a class to be instantiated, use an **object directly as the parent**.
- All children with the same parent observe the **very same object**.
- Changes from one child are visible to another child.
- The shared parent object is called a **prototype**.

**Self** is the archetypal prototype-based language. JavaScript is "based on" Self, but Self presents ideas in purest form.

**Argument:**

- Prototypes are more primitive than classes.
- With functions, one can recover classes from prototypes-but not the other way around.
- A "class" function contains an object description, so a **class is an object-returning-function**.

**Prototype implementation:**

```racket
(define (make-proto-child parent)
  (lambda (m)
    (case m
      [(child-method) (lambda () "child")]
      [else (parent m)])))  ; delegate to prototype directly

(define proto-parent
  (lambda (m)
    (case m
      [(parent-method) (lambda () "parent")])))

(define child1 (make-proto-child proto-parent))
(define child2 (make-proto-child proto-parent))
; child1 and child2 share the same proto-parent object
```

**Clone operation:** A prototype language might provide "clone" to simplify creating operations that simulate classes atop prototypes.

# Multiple inheritance

- Multiple fall-through options lead to **multiple inheritance**.
- Multiple objects to chain lookup raises the question of **order**.

**Problems:**

- Even a tree has no canonical traversal order (breadth-first vs depth-first each have uses).
- The **diamond problem**: A extends B and C; B and C each extend D.
    - Will there be **one or two D objects** in instance of A?
    - One saves space and matches expectations.
    - But will we **visit D once or twice**?
    - Visiting twice is unnecessary.
    - Visiting once means behavior of B or C might change.

This is called the **"Deadly Diamond of Death"**. Every multiple-inheritance language needs a subtle algorithm to define lookup order. If you include multiple inheritance, you can lose days in design decisions with no canonical answer.

# Mixins

**Key insight:** When we write `class C extends B { ... }` in Java, what's between the braces is a **class extension**, not a full class. It becomes a class because we identify the parent in the same place.

**Why not separate these acts?**

```
classext E { ... }       // define extension
class C = E(B)           // apply to base class
```

**The power:** Can apply the same extension to different bases:

```
class C1 = E(B1);
class C2 = E(B2);
```

- A **mixin** is a class extension liberated from the tyranny of a fixed base class.
- Mixins are **functions over classes**.
- Provide benefits of multiple inheritance within **single-inheritance** (no complicated lookup rules).
- Easy to implement: classes desugar to expressions that can be nested in functions.

**In typed languages:**

- A mixin should use **interfaces** to describe what it expects and provides.
- Java enables specifying what interfaces a class provides.
- Java does **not** enable specifying the parent as an interface.
- A class extension in Java extends the parent class with all members visible.
- If parent changes, the class might break.
- Mixins break this asymmetry.

```
mixin M extends I1 implements I2 { ... }
```

- `M` can only be applied to a class satisfying `I1`.
- Only members in `I1` are visible in `M`.
- Follows: **"Program to an interface, not an implementation"** -Design Patterns.
- A mixin has type: `M :: I1 -> I2`.

**Reusability advantage:** A class can only appear once in an inheritance chain (cycles would cause infinite loops). When composing functions, we use the same function multiple times: `(map ... (filter ... (map ...)))`. Mixins can be used multiple times too!

**Library design problem solved:**

- A dozen features combinable in different ways
- Impractical to generate entire combinatorial explosion of classes
- Not all features can be combined with each other
- Mixins let developers **pick and choose features** with interface-preservation preventing unreasonable combinations

**Example:** Racket GUI library uses mixins extensively. `color:text-mixin` consumes basic text editor interfaces and implements colored text editor interface. The result is still a basic text editor interface, so additional mixins can be applied.

# Traits

- **Traits** generalize mixins: instead of extending one mixin, extend a **set of them**.
- When extending more than one, must handle **name clashes**.
- Traits have mechanisms for resolving clashes: a **name-combination algebra**.
- Traits complement mixins; programmers choose based on needs.
- Racket provides **both mixins and traits**.

# Summary table

| Concept | Definition | Key implementation | Pitfalls/notes |
| --- | --- | --- | --- |
| **Object** | Value mapping names to stuff (values/methods) | Lambda + case dispatch | Generalization of closures |
| **Member** | Generic entry in object (field or method) | Case clause | - |
| **Object pattern** | `(lambda (m) (case m ...))` | Dispatch on member name | Target language may allow expressions with no source counterpart |
| **Constructor** | Function invoked at object creation | Wrap object in function | - |
| **Class pattern** | Function returning an object | `(define (class params) ...object pattern...)` | - |
| **State** | Mutable variables shared by methods | `set!` on constructor args | Alan Kay wanted to eliminate assignment, not enshrine it |
| **Private members** | Members visible only inside object | Lexically-scoped variables outside case | Aliasing can leak "private" data; Java privates visible to same-class instances |
| **Static members** | Members shared across all instances | Variables outside constructor, inside class | Should be accessible through class, not just objects |
| **Self-reference (mutation)** | Object referring to itself | Bind dummy, then mutate | Pattern underlies letrec |
| **Self-reference (no mutation)** | Pass object as parameter | Extra `self` param to methods | Dangerous if exposed (Python does this) |
| **Dynamic dispatch** | Invoke method without knowing handler | Runtime extracts and invokes method | Extensible conditional; dual advantage with functions |
| **Inheritance** | Chain lookup to parent object | `else` clause delegates to parent | - |
| **Class extension** | What goes in class braces | Function parameterized over parent-maker | Not a full class until combined with parent |
| **Open recursion** | Self refers to most-refined object | Pass most-refined as self parameter | Default self-reference is to syntactic object |
| **Prototype** | Shared parent object (not class) | Delegate directly to object, not maker | Changes visible to all children; Self is archetypal |
| **Diamond problem** | A extends B,C; both extend D | - | No canonical solution; "Deadly Diamond of Death" |
| **Mixin** | Class extension as function over classes | `class C = E(B)` | Single inheritance benefits, multiple inheritance reuse |
| **Mixin typing** | `M :: I1 -> I2` | Interfaces for expects/provides | "Program to an interface, not an implementation" |
| **Traits** | Extend a set of mixins | Name-combination algebra | Handles name clashes; complements mixins |

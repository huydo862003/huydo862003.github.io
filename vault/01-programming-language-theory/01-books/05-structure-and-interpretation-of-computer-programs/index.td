---
_type: PltBook
_label: 'Structure and Interpretation of Computer Programs'
date: '1996'
journey: fref("/01-programming-language-theory/index.td")
description: 'A foundational text on programming using Scheme/Lisp. Covers evaluation models, abstraction, data structures, higher-order procedures, symbolic computation, and modularity. Foreword by Alan J. Perlis.'
isbn: '978-0262510875'
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Reading"
tags:
  - 'fundamentals of programming language'
  - 'semantics'
---

**About**: Notes & exercises from *Structure & Interpretation of Computer Programs, 2nd edition* by Harold Abelson and Gerald Jay Sussman with Julie Sussman.

**Why Lisp/Scheme?**

- Lisp's descriptions of processes (called *procedures*) can themselves be represented as Lisp data.
- Lisp is excellent for writing programs that must manipulate other programs as data.
- Unique features for studying important programming constructs, data structures, and linguistic features that support them.

**Topics covered**:

- Chapter 1: Building abstractions with procedures - evaluation models, recursion vs iteration, higher-order procedures.
- Chapter 2: Building abstractions with data - data abstraction, pairs/lists/trees, sequences as interfaces, symbolic data, generic operations.
- Chapter 3: Modularity, objects and state - assignment, local state, streams, concurrency.

**Key ideas**:

- Every powerful language has 3 mechanisms: *primitive expressions*, *means of combination*, *means of abstraction*.
- Two kinds of elements: *procedures* (rules for manipulating data) and *data* (stuff we manipulate).
- Procedures are first-class: can be named, passed as arguments, returned as values, included in data structures.

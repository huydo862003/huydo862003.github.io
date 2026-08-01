---
_type: Book
title: 'Software foundations'
date: '2024'
journey: fref("journeys/programming-language-theory/index.td")
description: 'A machine-checked introduction to the mathematical underpinnings of reliable software. Uses the Rocq (Coq) proof assistant to teach logic, functional programming, operational semantics, and formal verification.'
url: "https://softwarefoundations.cis.upenn.edu/"
tags:
  - 'formal verification'
  - 'Rocq'
  - 'Coq'
  - 'type theory'
  - 'theorem proving'
children:
  - fref("journeys/programming-language-theory/books/software-foundations/logical-foundations.td")
---

- The mathematical underpinnings of reliable software.
  - Logic.
  - Computer-assisted theorem proving.
  - The Rocq prover.
  - Functional programming.
  - Operation semantics.
  - Logics and techniques for reasoning about programs.
  - Static type systems.
  - Property-based random testing.
  - Verification of practical C code.
- Target audience:
  - Advanced undergraduates.
  - PhD students.
  - Researchers.
- No background is assumed.
- 100% formalized & machine-checked.

    Intended to be read alongside an interactive session with Rocq.

- Building reliable software is hard:
  - The scale and complexity of modern systems.
  - The number of people involved.
  - The range of demands placed on them.
- The cost of bugs and insecurities increases when information processing is tightly integrated into society.
- Past responses to these problems from computer scientists and software engineers:
  - Recommendations about software projects teams management (e.g extreme programming).
  - Libraries' design philosophies (e.g. model-view-controller, publish-subscribe, etc.).
  - Programming languages' design philosophies (e.g. object-oriented programming, functional programming, etc.).
  - Mathematical techniques for specification and reasoning about properties of software.
  - Tools to validate these properties.

-> Software Foundations focuses on this last set of tools.

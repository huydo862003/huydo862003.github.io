---
_type: Book
title: "Programming languages: application and interpretation"
date: '2012'
journey: fref("programming-language-theory/index.td")
description: 'An accessible introduction to programming language design through implementation. Builds interpreters from scratch, covering closures, objects, mutation, and types using the SMoL (Standard Model of Languages) framework.'
url: "https://www.plai.org/"
tags:
  - 'interpreters'
  - 'language design'
  - 'programming languages'
  - 'closures'
children:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-2-evaluation.td")
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

- Why study programming languages?

    > Force precise thinking. Prove what code can and can't express. Understand why companies create languages for competitive edge.

- Core learning framework
  - SMoL - Standard Model of Languages

        The shared DNA of Java, Python, JavaScript, Ruby, etc:

        | Feature | What it means |
        | --- | --- |
        | Automatic memory | No manual allocation |
        | Eager evaluation | Compute arguments first |
        | First-class functions | Pass functions like data |
        | Mutable state | Variables can change |

        **Key insight:** Think in *features*, not paradigms (OOP vs functional is outdated).

  - SImPl - Standard Implementation Plan

        `Parse -> Syntax tree -> Recursive processing`

        Same pattern powers interpreters, compilers, and type-checkers.

  - Mystery languages

        Same syntax, different behaviors -> learn by contrasting how features vary.

- Tools

    | Tool | Purpose |
    | --- | --- |
    | **SMoL tutor** | Automated practice |
    | **Stacker** | Visualize program execution |
    | **Racket #lang** | Build custom languages |

Resources: `cs.brown.edu/courses/csci1730/`

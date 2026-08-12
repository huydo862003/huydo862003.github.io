---
_type: Concept
title: 'Concolic testing'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'design-principle'
---

A testing technique combining concrete execution with symbolic reasoning - runs program with real values while simultaneously tracking symbolic constraints, then solves constraints to generate inputs

A testing technique combining **concrete execution** with **symbolic reasoning** - runs program with real values while simultaneously tracking symbolic constraints, then solves constraints to generate inputs that explore new execution paths; aims for benefits of both testing (concrete values) and type checking (complete coverage).

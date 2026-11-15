---
_type: PltConcept
_label: 'Read-eval-print-loop (REPL)'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A program that provides an interactive interface for programmers to interact with a programming language in an adhoc and highly-responsive fashion. The name represents the typical phases of this interaction: The program reads the input from the user, evaluates it, prints out the result and loops.

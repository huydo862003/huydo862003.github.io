---
_type: PltConcept
_label: 'Language safety'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Language feature/design, Runtime) According to Types and programming languages, from the view of portability, a language whose behavior can be entirely determined by its programmer's manual, that is, it is not subject to the internals of the specific machine it runs on.
:::

::: info
(Language feature/design, Runtime) According to "Type system" [Luca Cardelli, 1996], a language with no [untrapped runtime error](/programming-language-theory/02-concepts/untrapped-runtime-error) at runtime.
:::

::: info
(Language feature/design, Runtime) According to Programming languages: Application and Interpretation, a language with [partiality](/programming-language-theory/02-concepts/partiality) operations and reported safety violations.
:::

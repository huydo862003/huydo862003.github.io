---
_type: PltConcept
_label: 'Environment'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'lambda calculus'
  - 'runtime'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(${fref("/programming-language-theory/concepts/lambda-calculus.td")}, Semantics) A finite map from variables to values, used to track substitutions during evaluation.
:::

- Written as: `\{x ↦ 5, y ↦ 3\}` or `[x := 5, y := 3]`.
- Extended when entering a function body: `env[x ↦ v]`.
- Consulted when evaluating a variable: `env(x)`.

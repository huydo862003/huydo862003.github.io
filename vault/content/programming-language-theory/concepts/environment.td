---
_type: Concept
title: 'Environment'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
---

::: info
(${fref("programming-language-theory/concepts/lambda-calculus.td")}, Semantics) A finite map from variables to values, used to track substitutions during evaluation.
:::

- Written as: `\{x ↦ 5, y ↦ 3\}` or `[x := 5, y := 3]`.
- Extended when entering a function body: `env[x ↦ v]`.
- Consulted when evaluating a variable: `env(x)`.

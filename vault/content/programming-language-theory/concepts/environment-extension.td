---
_type: Concept
_label: 'Environment extension'
title: 'Environment extension'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'semantics'
---

The operation $\\Gamma[x \\leftarrow t]$ that creates a new environment with all bindings from $\\Gamma$ plus variable $x$ bound to term/type/etc. $t$.

The operation $\Gamma[x \leftarrow t]$ that creates a **new** ${fref("programming-language-theory/concepts/environment.td")} with all bindings from $\Gamma$ plus variable $x$ bound to term/type/etc. $t$.

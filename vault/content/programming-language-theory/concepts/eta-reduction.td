---
_type: Concept
_label: 'Eta-reduction'
journey: fref("programming-language-theory/index.td")
status: 'learning'
tags:
  - 'lambda-calculus'
  - 'semantics'
---

The transformation of  $\lambda x.\ t\ x$  to $t$ where $x \notin FV(f)$ - eliminating a redundant ${fref("programming-language-theory/concepts/lambda-abstraction.td")} when a function simply passes its argument unchanged to another function.

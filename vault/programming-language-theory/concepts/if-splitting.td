---
_type: Concept
_label: 'If-splitting'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

A type system mechanism where conditionals narrow union types based on predicates - after if (mt? t), the type of t refines from BT (union) to just mt in that branch, implementing Flow-sensitive typin

A type system mechanism where **conditionals narrow union types** based on predicates - after `if (mt? t)`, the type of `t` refines from `BT` (union) to just `mt` in that branch, implementing ${fref("programming-language-theory/concepts/flow-sensitive-typing.td")}.

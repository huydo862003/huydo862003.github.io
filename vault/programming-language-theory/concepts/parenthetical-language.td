---
_type: PltConcept
_label: 'Parenthetical language'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

(define-syntax-rule (or a b) (if a a b))

```scheme
(define-syntax-rule (or a b) (if a a b))
(or x y) -> (if x x y)   ; macro just rearranges list elements
```

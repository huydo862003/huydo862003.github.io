---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What's special about the Church encoding of numbers and lists?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - church-numeral
books:
  - chapter-5-the-untyped-pure-lambda-calculus
---

- Both have a base value:
    - Number: 0.
    - List: Empty list.
- Both have an operation to "step" up a value that can cover the whole value universe of the type:
    - Number: +1.
    - List: cons with a value.
- With this, we can encode numbers and lists as:
    - Number: $\lambda a.\ \lambda z.\ a\ (a\ (a\ ...\ z))$.
        - $a$ stands for increment.
        - $z$ stands for zero.
        
        → A number $n$ roughly means applying increment $n$ times to zero.
        
    - List: $\lambda c.\ \lambda l.\ c\ e_0\ (c\ e_1\ (c\ e_2 \ ...\ l))$ .
        - $c$ stands for cons.
        - $l$ stands for empty list.
        
        → A list roughly means applying cons with a value $n$ times to the empty list.

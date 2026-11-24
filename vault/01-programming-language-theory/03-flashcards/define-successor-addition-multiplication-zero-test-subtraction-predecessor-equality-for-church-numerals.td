---
_type: PltFlashcard
_label: 'Define successor, addition, multiplication, zero test, subtraction, predecessor, equality for church numerals?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/pure-untyped-lambda-calculus.td")
  - fref("/01-programming-language-theory/02-concepts/church-numeral.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="Pure Lambda Calculus"}
Define successor, addition, multiplication, zero test, subtraction, predecessor, equality for church numerals?
=== key
Church numerals:

$$
c_n = \lambda a.\ \lambda z.\ \underbrace{a\ (a\ (\cdots (a}_{n}\ z)\cdots))
$$

- Successor:

    $\text{succ} = \lambda c.\ \lambda a.\ \lambda z.\ a\ (c\ a\ z)$.

- Addition:

    $\text{plus} = \lambda m.\ \lambda n.\ \lambda a.\ \lambda z.\ (m\ a\ (n\ a\ z))$.

- Multiplication:

    $\text{time} = \lambda m.\ \lambda n.\ m\ \text{plus}\ n$.

- Zero test:

    $\text{iszero} = \lambda c.\ c\ (\lambda \_.\ \text{fls})\ \text{tru}$

- Predecessor:

    $\text{pred} = \lambda c.\ \text{fst}\ (c\ (\lambda p.\ \text{pair}\ (\text{snd}\ p)\ (\text{succ}\ (\text{snd}\ p))) \ (\text{pair}\ c_0\ c_0))$

- Subtraction:

    $\text{sub} = \lambda m.\ \lambda n.\ n\ \text{pred}\ m$.

- Equality:

    $\text{eq} = \lambda m.\ \lambda n.\ (\text{and}\ (\text{iszero}\ (\text{sub}\ m\ n))\ (\text{iszero}\ (\text{sub}\ n\ m)))$
:::

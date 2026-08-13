---
_type: Concept
_label: 'Inductive hypothesis'
title: 'Inductive hypothesis'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
tags:
  - 'logic'
  - 'proof-reason-technique'
  - 'set-theory-relation'
---

$$
\displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{a\ J}
$$

we typically need to show:

$$
\displaystyle\frac{\mathcal{P}(a_1)\ \dots\ \mathcal{P}(a_k)}{\mathcal{P}(a)}
$$

In this case, all the ${fref("programming-language-theory/concepts/instance-of-the-judgment-form.td")}s $\mathcal{P}(a_i)$ are the **inductive hypotheses**.

---
_type: PltConcept
_label: 'Inductive conclusion'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
tags:
  - 'logic'
  - 'set theory relation'
---

$$
\displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{a\ J}
$$

we typically need to show:

$$
\displaystyle\frac{\mathcal{P}(a_1)\ \dots\ \mathcal{P}(a_k)}{\mathcal{P}(a)}
$$

In this case, the ${fref("programming-language-theory/concepts/instance-of-the-judgment-form.td")} $\mathcal{P}(a)$ is the **inductive conclusion**.

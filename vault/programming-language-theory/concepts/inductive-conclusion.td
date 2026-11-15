---
_type: PltConcept
_label: 'Inductive conclusion'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

$$
\displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{a\ J}
$$

we typically need to show:

$$
\displaystyle\frac{\mathcal{P}(a_1)\ \dots\ \mathcal{P}(a_k)}{\mathcal{P}(a)}
$$

In this case, the ${fref("/programming-language-theory/concepts/instance-of-the-judgment-form.td")} $\mathcal{P}(a)$ is the **inductive conclusion**.

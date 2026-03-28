---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Define boolean operations and, or, not for Church booleans?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - pure-untyped-lambda-calculus
books:
  - chapter-5-the-untyped-pure-lambda-calculus
---


Church booleans:

$$
\begin{aligned}
\text{tru} & = \lambda f.\ \lambda s.\ f \\
\text{fls} & = \lambda f.\ \lambda s.\ s
\end{aligned}
$$

- And:
    
    $\text{and} = \lambda b_1.\ \lambda b_2.\ b_1\ b_2\ \text{fls}$
    
- Or:
    
    $\text{or} = \lambda b_1.\ \lambda b_2.\ b_1\ \text{tru}\ b_2$
    
- Not:
    
    $\text{not} = \lambda b.\ b\ \text{fls}\ \text{tru}$

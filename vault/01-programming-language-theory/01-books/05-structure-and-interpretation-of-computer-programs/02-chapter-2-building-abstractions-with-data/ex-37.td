---
_type: PltBook
_label: 'Exercise 2.37'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Suppose we represent vectors $\mathbf{v} = (v_i)$ as sequences of numbers, and matrices $\mathbf{m} = (m_{ij})$ as sequences of vectors (the rows of the matrix). For example, the matrix

$$
\[
\begin{bmatrix}
1 & 2 & 3 & 4 \\
4 & 5 & 6 & 6 \\
6 & 7 & 8 & 9
\end{bmatrix}
\]
$$

is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))`. With this representation, we can use sequence operations to concisely express the basic matrix and vector operations. These operatons (which are descrived in any book on matrix algebra) are the following:

- `(dot-product v w)` returns the sum $\sum_iv_iw_i$.
- `(matrix-*-vector m v)` returns the vector $\mathbf{t}$, where $t_i=\sum_jm_{ij}v_j$.
- `(matrix-*-matrix m n)` returns the matrix $\mathbf{p}$, where $p_{ij}=\sum_k_{ik}n_{kj}$.
- `(transpose m)` returns the matrix $\mathbf{n}$, where $n_{ij} = m_{ji}$.

We can define the dot product as

```scheme
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
```

Fill in the missing expressions in the following procedures for computing the other matrix operations. (The procedure `accumulate-n` is defined in Exercise 2.36)

```scheme
(define (matrix-*-vector m v)
  (map <??> m))
(define (transpose mat)
  (accumulate-n <??> <??> mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map <??> m)))
```


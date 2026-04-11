---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to desugar letrec in Racket?
answer: TODO
deck: general
concepts: []
books:
  - chapter-4-objects
tags: []
keywords:
  - "lambda"
  - "expression"
  - "racket"
  - "arg1"
  - "arg2"
  - "arg3"
---


For context, simple `let` as:

```racket
(let ([x_1 arg1]
			[x_2 arg2]
			[x_3 arg3])
	expression)
```

would be desugared to:

```racket
((lambda (x_1 x_2 x_3) expression)
 arg1
 arg2
 arg3)
```

Assume `s` is a syntactic transformation such that `s(expression, x_1, x_2, x_3)` is `expression` with all occurrences of `x_1` to `((x_1 x_1 x_2 x_3))`, `x_2` to `((x_2 x_1 x_2 x_3))`, `x_3` to `((x_3 x_1 x_2 x_3))`.

Then, recursive `letrec`:

```racket
(letrec ([x_1 arg1]
				 [x_2 arg2]
				 [x_3 arg3])
	expression)
```

can be desugared to:

```racket
(let ([x_1 (lambda (x_1 x_2 x_3) (lambda () s(arg1, x_1, x_2, x_3)))]
      [x_2 (lambda (x_1 x_2 x_3) (lambda () s(arg2, x_1, x_2, x_3)))]
      [x_3 (lambda (x_1 x_2 x_3) (lambda () s(arg3, x_1, x_2, x_3)))])
  (let ([x_1 (x_1 x_1 x_2 x_3)]
        [x_2 (x_2 x_1 x_2 x_3)]
        [x_3 (x_3 x_1 x_2 x_3)])
    s(expression, x_1, x_2, x_3)))
```

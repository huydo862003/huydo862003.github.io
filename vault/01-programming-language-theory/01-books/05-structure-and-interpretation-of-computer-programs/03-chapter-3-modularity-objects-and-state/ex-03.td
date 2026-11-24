---
_type: PltBook
_label: 'Exercise 3.3'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/03-chapter-3-modularity-objects-and-state/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Modify the `make-account` procedure so that it creates password-protected accounts. That is, `make-account` should take a symbol as an additional argument, as in

```scheme
(define acc (make-account 100 'secret-password))
```

The resulting account object should process a request only if it is accompanied by the password with which the account was created, and should otherwise return a complaint:

```scheme
((acc 'secret-password 'withdraw) 40)
60
((acc 'some-other-password 'deposit) 50)
"Incorrect password"
```


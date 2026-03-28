---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Why is subclass = subtype a controversial choice?
answer: TODO
deck: type-theory
concepts: []
books:
  - chapter-5-types
---


**Subtyping** is a form of type polymorphism in which a subtype is a datatype that is related to another datatype (the supertype) by some notion of substitutability, meaning that program elements, typically subroutines or functions, written to operate on  elements of the supertype can also operate on elements of the subtype.

If `S` is a subtype of `T`, the subtyping relation is often written `S <: T`, to mean that any term of type `S` can be safely used in a context where a term of type `T` is expected. The precise semantics of subtyping crucially depends on the particulars of what "safely used in a context where" means in a given programming language.

**Subclassing** should not be confused with subtyping. In general, subtyping establishes an is-a relationship, whereas subclassing only reuses implementation and establishes a syntactic relationship, not necessarily a semantic relationship (inheritance does 
not ensure behavioral subtyping).

To distinguish these concepts, subtyping is also known as *interface inheritance*, whereas subclassing is known as *implementation inheritance* or *code inheritance.*

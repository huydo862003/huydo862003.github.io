---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Boolean blindness"
url: "Boolean Blindness"
author: ""
journey: plt
site: robert-harper
latestPost: ""
lastChecked: ""
posts: []
tags: ["PLT", "blog"]
---

## Phase 1

- Intro
    
    > "I hate Booleans! But isn't everything 'just bits'? Aren't computers built from gates? And aren't gates just the logical connectives? How can a Computer Scientist possibly hate Booleans?"
    > 
- Leading sentences
    
    > "Fritz Henglein recently pointed out to me that the world of theoretical Computer Science is divided into two camps... the logicians and the combinatorialists."
    > 
    
    > "My point is this. Booleans are just one, singularly (or, perhaps, binarily) boring, type of data."
    > 
    
    > "Booleans are almost invariably (in the CS literature and textbooks) confused with propositions, which express an assertion, or make a claim."
    > 
    
    > "The language here is delicate. The judgement that a proposition, $p$, is **true** is not the same as saying that $p$ is equal to **true**..."
    > 
    
    > "In classical mathematics, where computability is not a concern, it is possible to conflate the notions of Booleans and propositions..."
    > 
    
    > "A good example is the equality test, `e=e'`, of type bool."
    > 
    
    > "What harm is there in making this confusion?"
    > 
    
    > "Another harm is the condition of Boolean blindness alluded to earlier."
    > 
    
    > "But this is yet another example of an iatrogenic disorder!"
    > 
- Conclusion
    
    > "As an exercise, convince yourself that the entire business of 'null pointer analysis' is pointless, for exactly the same reasons! There are few things more stupid in the world than code that compares a pointer for equality with null, then branches on the outcome, and then finds itself needing a SAT solver or model checker to propagate the provenance of a boolean that should never have been computed in the first place!"
    > 

|  C  | Assessment | 
 | --- |  ---  |
|  **Contribution**  | - Introduces and names "Boolean blindness" as a concept-the loss of semantic information when computations collapse rich data into bits.
- Argues for pattern matching over boolean conditionals. |
 | **Context** |  - Written for the Programming Languages / Type Theory community.
- Part of a broader series on Harper's blog about types, equality, and constructive logic.
- Responds to common CS pedagogy that conflates booleans with propositions.  |
|  **Clarity**  | Mixed.
- The philosophical distinction (propositions vs. booleans) is subtle and may lose readers.
- The concrete `plus` example is very clear.
- The rhetorical opening is engaging but the middle sections are dense. |
 | **Correctness** |  - Technically sound within constructive type theory.
- The claim that "booleans and propositions are different types" is correct in intuitionistic logic.
- The practical programming advice (use pattern matching) is well-established.  |
|  **Category**  | - Philosophy of Programming / Type Theory / Language Design polemic.
- This is an opinion piece with theoretical grounding, not a research paper. |
## Phase 2

- General flow
    
    ```
    Opening Provocation
        │
        ▼
    Framing: Logicians vs. Combinatorialists
        │
        ▼
    Core Claim: "Booleans carry no information beyond their value"
        │
        ▼
    Philosophical Distinction: Booleans ≠ Propositions
        │
        ├── Propositions have proofs/refutations
        ├── Booleans are data values
        └── "Is p equal to true?" is a type error
        │
        ▼
    Classical vs. Constructive Mathematics
        │
        ├── Classical: can conflate bool/prop
        └── Computational: must distinguish them
        │
        ▼
    Concrete Example: Equality Test `e=e'`
        │
        ├── The notation invites confusion
        ├── The function and the proposition are different things
        └── Equality for functions: provable but not computable
        │
        ▼
    Harm #1: Pedagogical confusion (why can't we test function equality?)
        │
        ▼
    Harm #2: Boolean Blindness proper
        │
        ├── "The bit has no intrinsic meaning"
        ├── Must track provenance mentally
        └── "Lost in a thicket of if-then-else's"
        │
        ▼
    The Iatrogenic Disorder: Computing the bit is the mistake
        │
        ▼
    Concrete Example: plus function
        │
        ├── BAD: if x=Z then y else S(plus (pred x) y)
        └── GOOD: case x of Z => y  \vert S(x') => S(plus x' y)
        │
        ▼
    Closing Challenge: Null pointer analysis is equally pointless
    
    ```
    
- Keypoints
    1. **"There is no information carried by a Boolean beyond its value, and that's the rub."** - The core thesis in one sentence.
    2. **Propositions vs. Booleans distinction**: A proposition being "true" means it has a proof. A boolean being `true` is just a data value. These are different types. This is the philosophical foundation.
    3. **"Iatrogenic disorder"** - A medical term meaning "caused by the treatment." The problem isn't recovering information from booleans; it's computing the boolean in the first place.
    4. **The `plus` example**: Shows that pattern matching extracts the predecessor *en passant* (incidentally), whereas the boolean version must call `pred` and re-check the invariant.
    5. **"You cannot test equality of propositions!"** - A sharp consequence of the distinction. Mathematical equality of functions exists but is not computable.
- Flow Assessment
    
    **Strengths:**
    
    - The rhetorical opening hooks the reader.
    - The philosophical setup (bool vs prop) is necessary for the deeper argument.
    - The `plus` example is concrete and convincing.
    - The null pointer challenge at the end generalizes the point.
    
    **Disconnections/Weaknesses:**
    
    - The "logicians vs combinatorialists" framing is introduced but never developed-it's a rhetorical aside that doesn't connect to the main argument.
    - The jump from "equality test" to "Boolean blindness proper" is slightly abrupt-he's making two related but distinct harms.
    - The relationship between the philosophical distinction (bool ≠ prop) and the practical advice (use pattern matching) could be made more explicit.
    - The article assumes familiarity with SML/constructive type theory; the `case` syntax and the notion of "decidability" aren't explained.

## Phase 3

### Critique of Harper's Ideas

**1. The "logicians vs combinatorialists" framing is underdeveloped**

Harper opens with this dichotomy but drops it immediately. The claim that "logicians hate booleans" and "combinatorialists love bits" is provocative but unsupported. Many algorithm designers use rich data structures, and many logicians work with boolean satisfiability. This feels like tribal signaling rather than substantive argument.

**2. The bool/prop distinction is overstated for practical programming**

Harper's philosophical point is correct in type theory: propositions and booleans are distinct types. But in mainstream programming, this distinction rarely matters. Most programmers don't work with propositions-as-types. The practical advice (use sum types and pattern matching) stands on its own without the foundational philosophy.

**3. The critique is really about *information erasure*, not booleans per se**

The real issue Harper identifies is: **when you compute a boolean, you erase the evidence that justified it.** This is true of any lossy transformation, not just booleans. If you compute `length xs` and later need to know if the list was empty, you've erased information. Booleans are just the most extreme case (1 bit).

**4. The "iatrogenic disorder" framing is clever but incomplete**

Yes, computing the bit is the problem. But sometimes you *need* to compute a boolean-for serialization, for external APIs, for configuration flags. Harper's advice works when you control the entire call stack; it breaks down at system boundaries.

**5. The null pointer analogy is apt but the conclusion is too strong**

Calling null pointer analysis "pointless" ignores the reality that we inherit codebases full of nullable pointers. Analysis tools aren't ideal, but they're pragmatic. The ideal solution (option types everywhere) requires rewriting the world.

### Rephrasing in Our Terms

**What Harper is really saying:**

> Booleans are a form of premature abstraction. When you test a condition and reduce the result to true/false, you throw away the witness-the evidence that made the condition hold. Later code that branches on the boolean must either (a) trust the provenance, (b) re-check the condition, or (c) use external analysis to recover what was lost.
> 
> 
> **The fix is to preserve structure.** Instead of asking "is this a zero?" and getting a bit, ask "what shape is this?" and get back the shape itself (including any data it contains). Pattern matching does this naturally: it *destructs* a value into cases while *binding* the components, so the evidence is never lost.
> 
> **This is ultimately about making invariants explicit in types.** A boolean test establishes an invariant ("$x$ is non-zero"), but that invariant exists only in the programmer's head. A sum type makes the invariant structural: you literally cannot access the predecessor unless you're in the $S(x')$ branch.
> 

**A more practical formulation:**

| Anti-pattern | Problem | Solution |
| --- | --- | --- |
| `if isNull(x) then ... else use(x)` | Must trust that `x` is non-null in `else` branch | `match x with None -> ... | Some(v) -> use(v)` |
| `if isEmpty(list) then ... else head(list)` | `head` must re-check or trust provenance | `match list with [] -> ... | (h::t) -> use(h, t)` |
| `if x == 0 then ... else f(x-1)` | `x-1` must re-validate non-zero | `match x with Z -> ... | S(n) -> f(n)` |

**The general principle:**

> Don't ask questions; demand answers. A boolean test asks "is this condition true?" and gets back a yes/no. Pattern matching demands "show me which case you are" and gets back the case plus its contents. The difference is whether the evidence survives.
> 

**Where Harper's advice applies and doesn't:**

| Applies well | Applies poorly |
| --- | --- |
| Internal program logic | External API boundaries |
| Data validation at parse time | Legacy code with existing boolean interfaces |
| Languages with good sum types (ML, Rust, Haskell) | Languages where sum types are awkward (C, Java) |
| When you control the whole stack | When interoperating with boolean-returning libraries |

### Final Assessment

Harper's article is a classic polemic from the type theory tradition. The core insight-**booleans erase evidence**-is profound and actionable. The philosophical framing (bool ≠ prop) is correct but may obscure the practical point for mainstream programmers. The best takeaway is the concrete advice: **use pattern matching on sum types instead of boolean conditionals**, because this preserves the witness and lets the type system enforce invariants.

---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 1. introduction
author: Benjamin C. Pierce
date: ""
journey: plt
tags: []
concepts:
  - type-system
  - hoare-logic
  - model-checker-type-system-runtime-monitoring
  - runtime-type-error
  - safe-sound-type-system
  - language-safety
  - type-safety-language-safety
  - trapped-runtime-error-untrapped-runtime-error
parent: types-and-programming-languages
children: []
---

- Informally, though, safe languages can be defined as ones that make it impossible to shoot yourself in the foot while programming.
- A safe language is completely defined by its programmer's manual.
- Indeed, in typed languages the type system itself is often taken as the foundation of the design and the organizing principle in light of which every other aspect of the design is considered.

# Types in computer science

**Modern software engineering & formal methods**

- Modern software engineering uses a broad range of **formal methods** to ensure that a system behaves correctly with respect to a given **specification**.

---

**Heavyweight / classical formal methods**

- Examples:
    - **Hoare logic**
    - **Algebraic specification languages**
    - **Modal logics**
    - **Denotational semantics**
- Characteristics:
    - Able to express and prove **very general, strong correctness properties** about programs and systems.
    - [x] Often **cumbersome** to apply in practice.
    - [x] **Sophisticated and mathematically heavy**, making them difficult for everyday programmers to use without specialized training.

---

**Lightweight formal methods**

- Goal: Bring the benefits of formal reasoning into **everyday development workflows** in a more **practical and accessible** way.
- Main examples:
    - **Model checking**
        - Automatically explores the state space of a (usually finite-state) system.
        - Used to **search for violations** of properties (e.g., safety, liveness) and uncover subtle bugs such as race conditions or protocol errors.
    - **Run-time monitoring**
        - Adds monitors or checkers that **observe the system while it runs**.
        - Dynamically detects when a component's behavior **deviates from its specification** (for example, violating a protocol, contract, or temporal property).
    - **Type systems**
        - The **most popular and widely adopted** form of lightweight formal methods.
        - Statically rule out entire classes of errors (e.g., type mismatches, some invalid states) **before the program runs**.
- Advantages:
    - **Lightweight** enough to be integrated into:
        - Compilers
        - Linkers
        - Program analyzers
        - IDE tooling
    - Can be **readily used by programmers** without requiring deep knowledge of the underlying formal theories.
    - Fit naturally into existing **development workflows** (editing, compiling, testing), making formal reasoning more routine and scalable.

---

**On the term "type system"**

- The term **"type system"** is often **overloaded** in practice.
    - Programming language designers and implementers sometimes use it **informally**, to refer to slightly different ideas:
        - The static checker in a compiler
        - A particular typing discipline (e.g., Hindley-Milner, subtyping, linear types)
        - The overall design space of "what is considered a type" in a language
- Despite this informal and varied usage, **"type system" is still precise enough** in context:
    - In most PL discussions, it still means a **formal mechanism** that:
        - Classifies program phrases (expressions, functions, modules, etc.) into **types**
        - Enforces rules that guarantee certain **safety or correctness properties** (e.g., "well-typed programs don't go wrong")
    - The surrounding context (paper, language, or framework) usually makes **which notion of "type system"** is intended clear enough for technical communication.

---

**Type system definition**
:::tip
A **type system** is a **tractable syntactic method** for **proving the absence** of **certain program behaviors** by **classifying phrases according to the kinds of values they compute**.
:::

- Type system **as a tool for program reasoning**. → This definition reflects the book's orientation towards type systems found in programming languages.
    - More general sense
        - **"Type system" / "type theory"** also refers to a much broader field of study in **logic, mathematics, and philosophy**, not just programming languages.
        - Historically:
            - **Formalized in the early 20th century** as part of foundational work in logic and set theory.
            - One of the main motivations was to **avoid logical paradoxes**, such as **Russell's paradox**, by carefully organizing what kinds of objects and statements are allowed.
        - In this broader sense, type theory:
            - Provides an alternative foundation to **set theory** for mathematics.
            - Influences the design of **logical systems**, **proof assistants**, and **foundational theories** used in modern formal verification and PL research.
        - During the 20th century:
            - Types became standard tools in logic (proof theory).
            - Permeated the language of philosophy and science.
            - Major landmarks
                - Ramified theory of types (Whitehead and Russel, 1910)
                - Simple theory of types (Ramsey, 1925)
                - Simply typed lambda-calculus (Church, 1940)
                - Constructive type theory (Martin-Lof, 1973, 1984)
                - Pure type systems (Berardi, 1988; Terlouw, 1989; Barendregt, 1992).
        - Even in computer science, research on **type systems** tends to split into two broad directions:
            - Practical branch - type systems for programming languages
                - Focus:
                    - Designing and analyzing **type systems for real-world programming languages**.
                - Goals:
                    - Improve **safety** (catch more errors at compile time).
                    - Improve **developer productivity** (better tooling, refactoring, IDE support).
                    - Balance **expressiveness vs. simplicity** so everyday programmers can use the language effectively.
            - Abstract branch - type theory & typed λ-calculi
                - Focus:
                    - Studying **pure typed λ-calculi** as mathematical objects.
                    - Exploring connections between:
                        - Typed λ-calculi and **formal logics**
                        - Via the **Curry-Howard correspondence** (types ↔ propositions, programs ↔ proofs).
                - Goals:
                    - Understand the **foundations of computation and logic**.
                    - Relate programming languages, logics, and proofs in a unified framework.
            - Example: Termination in typed λ-calculi vs. real languages.
                - Many well-studied **typed λ-calculi** (for example, the simply-typed λ-calculus and some stronger systems) have the property that: **Every well-typed program is guaranteed to terminate** (they are *strongly normalizing*).
                - However, most real-world programming languages **sacrifice guaranteed termination**, because they:
                    - Allow **general recursion** (e.g., `let rec`, `fix`, recursive function definitions).
                    - Often include other features like **loops, side effects, and mutable state**.
                - Trade-off:
                    - **Theoretical systems**: strong guarantees (like termination), but less expressive for general-purpose programming.
                    - **Practical languages**: more expressive and convenient, but no global guarantee that all well-typed programs terminate.
- Type system **as classification of syntactic phrases** according to **the properties of the values that they will compute when executed**.
    - Type system can be seen **as calculating a kind of static approximation to the run-time behaviors of the terms in a program**.
    - Types assigned to terms are generally calculated compositionally, with the type of an expression depending only on the types of its subexpressions.
- Type systems are **static**.
    - However, sometimes the **static** word must be mentioned explicitly, as in **statically typed programming language** vs **dynamically typed programming language**.
        
        → To distinguish the sorts of **compile-time analyses** *we are considering here* from **the dynamic or latent typing** found in languages such as Scheme (Sussman and Steele, 1975; Kelsey, Clinger, and Rees, 1998; Dybvig, 1996), where **run-time type tags** are used to distinguish different kinds of structures in the heap.
        
    - Terms like "**dynamically typed**" are arguably **misnomers** and should probably be replaced by "**dynamically checked**" but the usage is standard.
- Type systems are **conservative**.
:::note

    
    Mnemonic
    
    Would you want a program that proves:
    
    - A certain program $X$ does not have bad behaviors.
    
    or
    
    - A certain program $X$ does have bad behaviors.
    
    Note that our program may fail to construct a proof.
:::
    
    - They can **prove the absence** of certain bad behaviors (e.g., "this program will never apply an integer as a function").
    - But they **cannot, in general, prove the presence** of such bad behaviors.
    - Consequences
        - A type system may **reject some programs that would actually run just fine** at runtime.
        - These are **false negatives** from the programmer's point of view: safe programs that are not accepted as well-typed.
        - Example:
            
            ```
            if <complex test> then 5 else <type error>
            ```
            
            - Suppose:
                - `<complex test>` is a condition that, in reality, **always evaluates to true**.
                - The `else` branch contains an expression that would cause a **type error**.
            - At runtime, the `else` branch would **never be executed**, so the program would behave safely.
            - However, a **static type checker**:
                - Must type-check **both branches** of the `if`.
                - Sees that the `else` branch is ill-typed.
                - **Rejects** the whole program as ill-typed, because it cannot *prove* that the `else` branch is unreachable.
    - Conservativity vs. expressiveness
        - **Conservativity**: Be safe; never accept programs that might go wrong.
        - **Expressiveness**: Accept as many useful, well-behaved programs as possible.
        - In practice:
            - Type systems must **err on the side of safety**.
            - This means they sometimes **reject perfectly good programs** that they cannot statically justify.
        - Key design tension: The trade-off between **safety (conservativity)** and **expressiveness** is a **fundamental fact of life** in type system design.
    - Main driving force: Allow more programs to be typed by assigning more accurate types to their parts. → Increased expressiveness but preserved safety.
- Most type systems are **not capable of forbidding arbitrary undesired program behaviors**. → Can only guarantee that well-typed programs are **free from certain kinds of misbehavior**.
    - Most cannot detect out-of-bound array indexing.
    - Most cannot detect division by zero.
- **Runtime type errors**: The set of **bad behaviors** the type system intends to eliminate. → Per-language choice.
    
    → The safety (or soundness) of each type system must be judged with respect to its own set of run-time errors.
    
    → A type system that aims to prevent no bad behavior at all is safe.
    
- Type analysis can detect more than low-level faults, for example:
    - Enforce higher-level modularity poperties.
    - Protect the integrity of user-defined abstractions.
- Typecheckers must embody **automatic, computationally tractable analyses**, requiring no interaction/interference with the programmer.
    - Programmers can still provide guidance via **type annotations** (usually kept fairly light).
    - In principle, a **full proof** that the program **meets some arbitrary specification** could be **encoded in type annotations**.
        
        → The typechecker would effectively become a **proof checker**.
        
        → Technologies like Extended Static Checking (Detlefs, Leino, Nelson, and Saxe, 1998) aim to settle the territory between **type systems** and **full-scale program verification methods**.
        
- Type checking algorithms should not only be **automatable** in principle but also should be **efficient**.
    
    What counts as efficient?
    
    - ML (Damas and Milner, 1982) may have huge typechecking time in pathological cases (Henglein and Mairson, 1991).
    - Some languages have type checking or type reconstruction problems that are undecidable, but algorithms halt quickly in most cases of practical interest (Pierce and Turner, 2000; Nadathur and Miller, 1988; Pfenning, 1994).

# What are type systems good for?

## Error detection

- Detect errors early.
- Pinpoint errors more accurately.
- Can catch both trivial mental slips and deeper conceptual mistakes.
:::tip
"Programmers working in richly typed languages often remark that their programs tend to "just work" once they pass the typechecker, much more often than they feel they have a right to expect".
:::

- How much benefit you get depends on the **expressiveness of the type system** and the **nature of the programming task**:
    - The more complex and structured your data (e.g., many data structures, invariants, and interfaces), the more useful types become.
    - For code involving only minimal, simple types-such as mostly numeric calculations in scientific applications-the benefit may seem smaller, though more **refined type systems** (for example, those supporting **dimension analysis**, as in Kennedy, 1994) can still add significant value.
- To get the most benefit from a type system, programmers need both:
    - Attention.
    - Willingness to engage with it.
- Expressive type systems offer many tricks for encoding information about program structure directly in types, making more invariants checkable at compile time.
- Type system can be an **invaluable maintenance tool**: Once the declaration of the datatype has been changed, all of these sites become type-inconsistent, and they can be enumerated simply by running the compiler and examining the points where typechecking fails.

## Abstraction

- Enforce disciplined programming.
- In software composition, type systems form the backbone of the module languages used to package and tie together the components of large systems.
- Structure large systems in terms of modules with clear interfaces → more abstract style of design.

## Documentation

- Types are live documentation that cannot be outdated as the compiler always recheck them.

## Language safety

- "**Safe language**" is even more ambiguous than type systems.
    - Generally based on guts feelings.
    - Depend on the language community.
:::tip
"Informally, though, safe languages can be defined as ones that make it impossible to shoot yourself in the foot while programming".
:::

- A **safe language** is one that **protects its own abstractions**.
    - Every high-level language provides abstractions of machine services.
    - Safety refers to the **language's ability** to **guarantee the integrity of these abstractions** and **of higher-level abstractions** introduced by the programmer using the definitional facilities of the language.
    - Example:
        - A language may provide arrays, with access and update operations, as an abstraction of the underlying memory.
        - A programmer using this language then expects that an array can be changed only by using the update operation on it explicitly-and not, for example, by writing past the end of some other data structure.
        
        → In a safe language, such abstractions can be used **abstractly**.
        
        → in an unsafe language, they cannot: in order to completely understand **how a program may (mis)behave**, it is necessary to keep in mind **all sorts of low-level details** such as the layout of data structures in memory and the order in which they will be allocated by the compiler.
        
    - Programs in unsafe languages may disrupt not only **their own data structures** but even those of the **run-time system**; the results in this case can be completely arbitrary.
- **Language safety** ≠ **Static type safety**
    - Language safety can be achieved by static checking + runtime checks (trap nonsensical operations just at the moment when they are attempted and stop the program or raise an exception).
- **Unsafe languages** often provide **"best effort" static type checkers** that help programmers eliminate at least **the most obvious sorts of slips**, but such languages do not qualify as type-safe either, according to our definition, since they are generally **not capable of offering any sort of guarantees** that **well-typed programs are well behaved**.
    
    → Typecheckers for these languages can **suggest the presence of run-time type errors** (which is certainly better than nothing) but **not prove their absence**.
    


|            | Statically checked          | Dynamically checked                    |
|------------|----------------------------|----------------------------------------|
| **Safe**   | ML, Haskell, Java, etc.    | Lisp, Scheme, Perl, Postscript, etc.   |
| **Unsafe** | C, C++, etc.               |                                        |

- Why is the bottom right slot empty?
    
    → Once facilities are in place for enforcing the safety of most operations at run time, there is little additional cost to checking all operations.
    
- A few **dynamically checked languages** **do offer low-level primitives** which can be **misused** to destroy the integrity of the run-time system.
- **Run-time safety** cannot be achieved by **static typing** alone.
    - All the safe languages above perform **array-bounds checking** **dynamically**.
    - Statically checked languages sometimes choose to provide operations whose **typechecking rules are unsound** (such as downcasting).
        
        → Language safety is achieved by dynamic checking.
        
- Language safety is not absolute. → Safe languages often offer programmers "escape hatches," such as foreign function calls to code written in other, possibly unsafe, languages.
- [Cardelli, 1996] provides a **different perspective** on language safety.
→ **Trapped runtime error** vs **untrapped runtime error**.
    - Trapped error: Computation stop immediately.
    - Untrapped error: Allow computation to continue.
    - Safe language: Prevent untrapped errors at run time.
- **Portability-wise**, a safe language can be described by its programmer's manual.
:::note
:::tip
     "A safe language is completely defined by its programmer's manual."
:::
    
    - Let the definition of a language be the set of things the programmer needs to understand in order to predict the behavior of every program in the language.
    - Then the manual for a language like C does not constitute a definition, since the behavior of some programs cannot be predicted without knowing the details of how a particular C compiler lays out structures in memory, etc., and the same program may have quite different behaviors when executed by different compilers.

## Efficiency

- Fortran used (the first) type system to improve the efficiency of numerical calculations.
- Further efficiency improvements are gained by eliminating many of the dynamic checks that would be needed to guarantee safety (by proving statically that they will always be satisfied).
- Most high-performance compilers rely heavily on information gathered by the typechecker during optimization and code-generation phases.
- Even compilers for languages without type systems per se work hard to recover approximations to this typing information.
- Recent work shows that information from type analysis can improve not only **code generation decisions** but also **pointer representations in parallel scientific programs**.
    - The Titanium language [Yelick et al., 1998] uses **type inference** to **analyze pointer scopes** and, on this basis, makes measurably better decisions than programmers manually hand-tuning their code.
    - The ML Kit compiler uses a powerful region inference algorithm [Gifford, Jouvelot, Lucassen, and Sheldon, 1987; Jouvelot and Gifford, 1991; Talpin and Jouvelot, 1992; Tofte and Talpin, 1994, 1997; Tofte and Birkedal, 1998] to replace most-sometimes all-garbage collection with stack-based memory management.

## Further applications

- Computer and network security
    - Java & JINI PnP architecture [Arnold, 1999]
    - Proof-Carrying Code [Necula & Lee, 1996, 1998; Necular, 1997]
    - Rephrase other fundamental ideas in security as type analyses [Abadi, Banerjee, Heintze, Riecke, 1999; Abadi, 1999; Leroy and Rouaix, 1998]
    - Applying PLT to security domain problems [Abadi, 1999; Sumii & Pierce, 2001]
- Typechecking & inference algorithms can be used in other program analysis tools other than compilers.
    - AnnoDomini (Y2K conversion utility for Cobol programs) is based on ML-style type inference engine [Eidorff et al., 1999]
    - Alias analysis [O'Callahan & Jackson, 1997]
    - Exception analysis [Lerot & Pessaux, 2000]
- Automated theorem proving: Type systems - usually very powerful ones based on dependent types-are used to represent logical propositions and proofs.
    - NuPRL [Constable, 1986]
    - Lego [Luo & Pollack, 1992; Pollack, 1994]
    - Coq [Barras, 1997]
    - Alf [Magnusson & Nordstrom, 1994]
    
    → These systems are all based on type theory.
    
    → History of these systems: [Constable, 1998; Pfenning, 1999]
    
- Database:
    - Web metadata: DTD [XML, 1998] & others such as XML Schema standard [XS, 2000].
    - **New XML query languages** employ **powerful static type systems** that are derived directly from **XML schema languages**, enhancing reliability in data manipulation.
        
        [Hosoya and Pierce, 2000; Hosoya, Vouillon, and Pierce, 2001; Hosoya and Pierce, 2001; Relax, 2000; Shields, 2001]
        
- Computational linguistics:
    
    The logical foundation of **Typed Lambda-Calculi** (TLC) provides a formal framework for analyzing natural language syntax and semantics, most notably connecting directly to **Categorial Grammar** (CG) for linguistic modeling [van Benthem, 1995; Ranta, 1995].
    

# Type systems and language design

- **Challenge:** Retrofitting a type system onto a language **not designed with typechecking in mind can be tricky**; ideally, **language design should go hand-in-hand with type system design.**
- **Languages without built-in type systems** tend to **offer features** and **encourage programming idioms** that inherently make robust static typechecking difficult or even infeasible.
    
    → For effective type safety, the **type system** must be the **foundational element** around which the entire language design revolves.
:::tip
"Indeed, in typed languages the type system itself is often taken as the foundation of the design and the organizing principle in light of which every other aspect of the design is considered."
:::

- **Typed languages** generally have **more complicated concrete syntax** than **untyped languages** because they must account for **type annotations**.
    
    → Designing a **clean and comprehensible syntax** is easiest when the language and type system issues are addressed **together** (reinforcing the idea that they should go hand-in-hand).
    
- The necessity of types being an **integral part** of the language ≠ the question of **where the programmer must physically write annotations** versus where the types can be **inferred by the compiler**.
- A **well-designed statically typed language** should **not require huge amounts of type information** to be tediously maintained by the programmer.
    - **Minimal annotation (e.g., ML family):** These languages prioritize **type inference methods** to keep explicit annotations to a bare minimum.
    - **Verbose style (e.g., C family, Java):** These languages have opted for a **somewhat more verbose** annotation style, requiring more explicit typing from the programmer.

# Capsule history

- Earliest type systems: used to make very simple distinctions between integer and floating point representations of numbers (e.g., in Fortran).
- In the late 1950s and early 1960s, this classification extended to structured data & higher-order functions.
- In the 1970s, richer concepts arose: parametric polymorphism, abstract data type, module systems, subtyping.
    
    → Type system becomes a field in its own rights.
    
    → Computer scientists began to be aware of the connections between **the type systems found in programming languages** and **those studied in mathematical logic**, leading to a rich interplay that continues to the present.
    

# Related reading

This section lists foundational texts and articles for studying type systems, categorized by their primary focus.

### General Introductions & Comprehensive Textbooks

- **Quick Introductions:**
    - Handbook articles by [Cardelli, 1996] and [Mitchell, 1990b].
- **Mathematically Inclined:**
    - Article by [Barendregt, 1992].
- **Comprehensive Foundations:**
    - **Foundations for Programming Languages** [Mitchell, 1996]: Covers basic λ-calculus, various type systems, and semantics, focusing on theoretical rather than implementation issues.
    - **Theories of Programming Languages** [Reynolds, 1998b]: A graduate-level survey with strong expositions of polymorphism, subtyping, and intersection types.
    - **The Structure of Typed Programming Languages** [Schmidt, 1994]: Develops core concepts within the context of language design, including imperative languages.
    - **Basic Simple Type Theory** [Hindley, 1997]: Deep coverage of the simply typed λ-calculus and related systems.

### Object-Oriented Type Systems

- **Theory of Objects:**
    - **A Theory of Objects** [Abadi and Cardelli, 1996]: Concentrates on applying type system ideas to form a foundational treatment of **object-oriented programming**, de-emphasizing implementation.
    - **Foundations of Object-Oriented Languages: Types and Semantics** [Bruce, 2002]: Covers similar ground.
- **Introductory Material:**
    - Articles by [Palsberg and Schwartzbach, 1994] and [Castagna, 1997].

### Semantics and Foundational Theory

- **General Semantics (Untyped & Typed):**
    - Textbooks by [Gunter, 1992], [Winskel, 1993], and [Mitchell, 1996].
- **Operational Semantics:**
    - Detailed coverage in [Hennessy, 1990].
- **Category Theory (Mathematical Semantics):**
    - Books by [Jacobs, 1999], [Asperti and Longo, 1991], and [Crole, 1994].
    - A brief primer: **Basic Category Theory for Computer Scientists** [Pierce, 1991a].

### Types and Logic

- **Logic and Type Systems (Curry-Howard Correspondence):**
    - **Proofs and Types** [Girard, Lafont, and Taylor, 1989]: Treats logical aspects, including the Curry-Howard correspondence, System F, and linear logic.
    - **Computation and Deduction** [Pfenning, 2001]: Further explores connections between types and logic.
- **Functional Programming and Constructive Logic:**
    - **Type Theory and Functional Programming** [Thompson, 1991].
    - **Constructive Foundations for Functional Languages** [Turner, 1991].
- **Proof Theory:**
    - **Proof Theory and Automated Deduction** [Goubault-Larrecq and Mackie, 1997].
- **History and Philosophy:**
    - Articles by [Constable, 1998], [Wadler, 2000], [Huet, 1990], and [Pfenning, 1999].
    - Books/Dissertations by [Laan, 1997], [Grattan-Guinness, 2001], and [Sommaruga, 2000].

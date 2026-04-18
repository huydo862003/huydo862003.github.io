---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 2. inductive definitions
author: Benjamin C. Pierce et al.
date: ""
journey: plt
tags: []
concepts:
  - axiom-inference-rule
  - judgment-assertion-judgment-form-judgment-form-instance-s
  - inductive-definition-judgment-form
  - axiom-rule-proper-rule
  - rule-scheme-inference-rule-metavariable
  - judgment-judgment-form
  - derivation-derivation-tree
  - derivation-forward-chaining-backward-chaining-bottom-up
  - forward-chaining-backward-chaining
  - forward-chaining-search-backward-chaining-search
  - forward-chaining
  - backward-chaining-search-goal-directed
  - forward-chaining-forward-chaining-search
  - backward-chaining-search-backward-chaining
  - rule-induction
  - mathematical-induction
  - tree-induction
  - iterated-inductive-definition-simultaneous-inductive
  - simultaneous-inductive-definition
  - inductive-definition-function
parent: logical-foundations
children: []
---

Inductive definitions cannot be dispensed in the study of programming languages.

- TLDR
    - Basic framework of inductive definitions.
    - Examples of inductive definitions.
    - Inductive definition = A set of Rules for deriving Judgments/Assertions of a variety of forms.
        - Judgment: A statement about one or more [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt)s of some Sort.
        - The rules specify necessary and sufficient conditions for the validity of a judgment. → Fully determine its meaning.

# Judgments

- TLDR: Judgment/Assertion about an [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt).
- Many forms of judgments:
    
    $$
\begin{aligned}
n\ \text{nat} & & & \text{$n$ is a natural number}\\
n_1 + n_2 = n & & & \text{$n$ is the sum of $n_1$ and $n_2$}\\
\tau\ \text{type} & & & \text{$\tau$ is a type}\\
e : \tau & & & \text{expression $e$ has type $\tau$}\\
e \Downarrow v & & & \text{expression $e$ has value $v$}
\end{aligned}
$$
    
    - Personal notes
        - The notation $e : \tau$ is familiar.
        - $e \Downarrow v$ is maybe similar to Big-step/Natural operational semantics.
        - $n_1 + n_2 = n$ is not a boolean ([[**Boolean Blindness**](https://existentialtype.wordpress.com/2011/03/15/boolean-blindness/)]).
        - $n\ \text{nat}$ and $\tau\ \text{type}$ have the same structure but totally different meaning.
- Judgment: A statement that one or more [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt)s have a property (unary relation) or stand in some relation to one another.
    - The property/relation $\to$ Judgment form.
    - The judgment that an object or objects have that property or stand in that relation $\to$ An Instance of an inference rule.
- Judgment form = Predicate.
    
    The objects constituting an instance are its subjects. $\to$ Judgment form instance's subject.
    
- The Judgment asserting that a Judgment form $J$ holds of the [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt) $a$ is written as $a\ J$ or $J\ a$. $\to$ Instance of the judgment form.
- A general Judgment form can be written as $J\ -$ or $-\ J$.
- When it is not important to stress the subject of the judgment, we write $J$ to stand for an unspecified judgment, that is, an instance of some judgment form.

# Inference rules

- An Inductive definition of a Judgment form consists of a collection of Rules of the form:
    
    $$
    \displaystyle\frac{J_1\ J_2\ \dots\ J_k}{J}
    $$
    
    in which $J$ and $J_1$, $J_2$, $\dots$, $J_k$ are all judgment of the form being defined.
    
    - The judgments above the line: Premises.
    - The judgment below the line: Conclusion.
    - No Premise $\to$ Axiom.
        
        Otherwise, a Proper rule.
        
- If all premises hold $\to$ The conclusion hold.
    
    The reverse does not hold.
    
- Example - Inductive definition of the judgment form $-\ \text{nat}$
$$
    \displaystyle\frac{}{\text{zero}\ \text{nat}}
    $$
    
$$
\displaystyle\frac{a\ \text{nat}}{\text{succ}(a)\ \text{nat}}
$$
    
- Example - Inductive definition of the judgment form $-\ \text{tree}$
$$
\displaystyle\frac{}{\text{empty}\ \text{tree}}
$$
$$
\displaystyle \frac{a\ \text{tree}}{\text{node}(a_1;a_2)\ \text{tree}}
$$
    
- Example - Inductive definition of the judgment form $-\ \text{is}\ -$
$$
\displaystyle\frac{}{\text{zero}\ \text{is}\ \text{zero}}
$$
$$
\displaystyle\frac{a\ \text{is}\ b}{\text{succ}(a)\ \text{is}\ \text{succ}(b)}
$$
    

$\Rightarrow$ A notational convention for specifying an infinite family of Rules by a finite number of patterns, or Rule schemes.

- A collection of Rules is considered to define the **strongest** Judgment form that is **closed under, or respects, those rules**.
    - Closed under the rules = The rules are **sufficient** to show the validity of a judgment: $J$ holds if there is a way to obtain it using the given rules.
    - Strongest judgment form = The rules are also **necessary**: $J$ holds only if there is a way to obtain it by applying the rules.
    
    $\to$ The sufficiency of the rules means that we may show that $J$ holds by deriving it by composing rules.
    
    $\to$ Their necessity means that we may reason about it using rule induction.
    

# Derivations

- To prove an **inductively defined Judgment**, it's sufficient to show a Derivation of it.
- Derivation of a Judgment: A finite composition of rules, starting with axioms and ending with that judgment.
    
    $\to$ A Derivation of $J$ is evidence for the validity of an inductively defined judgment $J$.
    
- Derivations are visualized as trees with the conclusion at the bottom and with the children of a node corresponding to a rule appearing above it as evidence for the premises of that rule.
    
    Formalization:
    
    - An inference rule: $\displaystyle\frac{J_1\ \dots\ J_k}{J}$.
    - Derivations of its premises:  $\triangledown_1, \dots, \triangledown_k$.
    
    $\to$ $\displaystyle\frac{\triangledown_1\ \dots\ \triangledown_k}{J}$ is a derivation of $J$.
    
- Two main methods for finding derivations:
    - Forward chaining/Bottom-up construction.
        
        Start with the axioms and work towards the desired conclusion.
        
        Idea: Forward chaining search maintains a set of derivable judgments and continually extends this set by adding to it the conclusion of any rules all of whose premises are in that set.
        
        Assume that all rules are considered at every stag:
        
        - Forward chaining would eventually find a derivation of any derivable judgment. $\to$ Complete.
        - Forward chaining cannot decide when to stop & conclude that a judgment is not derivable.
            
            $\to$ Need to understand the global properties of the rules.
            
        
        Do not take into account the end goal when deciding how to proceed at each step. $\to$ Undirected.
        
    - Backward chaining/Top-down construction.
        
        Start with the desired conclusion and work backwards towards the axioms. $\to$ Goal-directed.
        
        1. **Initialization:** The process begins with a queue containing only the final goal (the judgment to be derived).
        2. **The loop:**
            - A goal is removed from the queue.
            - The system searches for rules where the **conclusion** matches that goal.
            - The **premises** of those matching rules are added to the queue as new sub-goals.
        3. **Success:** The process terminates successfully when the queue is empty (all goals and sub-goals are satisfied).
        
        Same issues as Forward chaining.
        

# Rule induction

- An Inductive definition specifies the strongest Judgment form closed under a collection of rules.
    
    $\to$ We can reason about them using Rule induction.
    
- The principle of Rule induction states that to show that a property a $a\ \mathcal{P}$ holds whenever a $a\ J$ is Derivable, it is enough to show that $\mathcal{P}$ is closed under, or respects, the rules defining the judgment form $J$.
    
    More precisely, the property $\mathcal{P}$ respects the rule:
    
    $$
    \displaystyle\frac{a_1\ J \ \dots \ a_k\ J}{J}
    $$
    
    if $\mathcal{P}(a)$ holds whenever $\mathcal{P}(a_1 ), \dots , P(a_k)$ do.
    
    $\to$ The assumptions $\mathcal{P}(a_1), \dots , P(a_k)$ are called the Inductive hypothesis, and $\mathcal{P}(a)$ is called the Inductive conclusion of the inference.
    
- To show that $\mathcal{P}\ a$ whenever $a\ \text{nat}$, it's **sufficient** to show that:
    - $\mathcal{P}(\text{zero})$.
    - For every $a$, if $\mathcal{P}(a)$ then $\mathcal{P}(\text{succ}\ a)$.
    
    $\to$ The principle of Mathematical induction.
    
- To show that $\mathcal{P}\ a$ whenever $a\ \text{tree}$, it's **sufficient** to show that:
    - $\mathcal{P}(\text{empty})$.
    - For every $a_1$ and $a_2$, if $\mathcal{P}(a_1)$ and $\mathcal{P}(a_2)$ then $\mathcal{P}(\text{node}(a_1; a_2))$.
    
    $\to$ The principle of Tree induction.
    

# Iterated and simultaneous inductive definition

- Iterated inductive definition: One inductive definition builds on top of another.
    
    $\to$ The premises of a rule $\displaystyle\frac{J_1\ \dots\ J_k}{J}$ may be instances of either a previously defined judgment form, or the judgment form being defined.
    
    Example: The $-\ \text{list}$ Judgment form.
    
    $$
    \displaystyle\frac{}{\text{nil}\ \text{list}}
    $$
$$
\displaystyle\frac{a\ \text{nat} \quad b\ \text{list}}{\text{cons}(a; b)\ \text{list}}
$$
    
- Simultaneous inductive definition: A set of rules for deriving instances of several different judgment forms, any of which may appear as the premise of any rule.
    
    $\to$ Those judgment forms are defined at once.
    
    Example: The $-\ \text{even}$ and $-\ \text{odd}$ Judgment forms.
    
    $$
    \displaystyle\frac{}{\text{zero}\ \text{even}}
    $$
$$
\displaystyle\frac{a\ \text{even}}{\text{succ}(a)\ \text{odd}}
$$
$$
\displaystyle\frac{a\ \text{odd}}{\text{succ}(a)\ \text{even}}
$$
    
    $\to$ To show simultaneously that $\mathcal{P}(a)$ whenever $a\ \text{even}$ and $\mathcal{Q}(b)$ whenever $b$ odd, it is enough to show the following:
    
    1. $\mathcal{P}(\text{zero})$.
    2. For every $a$, if $\mathcal{P}(a)$ then $\mathcal{Q}(\text{succ}(a))$.
    3. For every $a$, if $\mathcal{Q}(a)$ then $\mathcal{P}(\text{succ}(a))$.

# Defining functions by rules

- Functions can be defined by:
    1. Providing the definition of its graph relating inputs to outputs.
    2. Then showing that the relation uniquely determines the outputs for given inputs.
- Example: The function $\text{sum}(a;b;c)$ with the intended meaning of $c$ being the sum of $a$ and $b$.
    
    $$
    \displaystyle\frac{b\ \text{nat}}{\text{sum}(\text{zero};b;b)}
    $$
$$
\displaystyle\frac{\text{sum}(a;b;c)}{\text{sum}(\text{succ}(a);b;\text{succ}(c))}
$$
    
    **Theorem.** For every $a\ \text{nat}$ and $b\ \text{nat}$, there exists a unique $c\ \text{nat}$ such that $\text{sum}(a;b;c)$.
    
<details>

<summary>Proof</summary>


Two parts:

- Existence: If $a\ \text{nat}$ and $b\ \text{nat}$, then there exists $c\ \text{nat}$ such that $\text{sum}(a;b;c)$.
- Uniqueness: If $\text{sum}(a;b;c)$, and $\text{sum}(a;b;c')$, then $c$ is $c'$.

</details>

# Exercises

## Exercise 2.1

**Problem statement.** Give an inductive definition of the judgment $\text{max}(m;n;p)$, where $m\ \text{nat}$, $n\ \text{nat}$, and $p\ \text{nat}$, with the meaning that $p$ is the larger of $m$ and $n$. Prove that every $m$ and $n$ are related to a unique $p$ by this judgment.

<details>

<summary>Solution</summary>

- Definition

$$
\displaystyle\frac{n\ \text{nat}}{\max(\text{zero};n;n)} \quad (1)
$$

$$
\displaystyle\frac{n\ \text{nat}}{\max(n;\text{zero};n)}\quad (2)
$$

$$
\displaystyle\frac{\max(m;n;p)}{\max(\text{succ}(m); \text{succ}(n); \text{succ}(p))} \quad (3)
$$

- The judgment defines a function on $m$ and $n$
    - Existence $(*)$: For every $m\ \text{nat}$ and $n\ \text{nat}$, there exists a $p$ such that $\max(m;n;p)$.
        - If $m = \text{zero}$ or $n = \text{zero}$, applying $(1)$ or $(2)$ suffices to show $(*)$ holds in these cases.
        - If $m = \text{succ}(m')$ and $n = \text{succ}(n')$, then with $(3)$, it's sufficient to show that $(*)$ holds in the case $m = m'$ and $n = n'$. By the induction hypothesis, this is trivial.
    - Uniqueness $(**)$: For every $m\ \text{nat}$ and $n\ \text{nat}$, if there exists $p$ and $p'$ such that $\max(m;n;p)$ and $\max(m;n;p')$, then $p = p'$.
        - If $m = \text{zero}$ or $n = \text{zero}$, applying $(1)$ or $(2)$ is the only way to obtain such a $p$. Therefore, $(**)$ holds in these cases.
        - If $m = \text{succ}(m')$ and $n = \text{succ}(n')$, then applying $(3)$ for the case $m = m'$ and $n = n'$ is the only way to obtain such a $p$. By the induction hypothesis, this is trivial.

</details>



## Exercise 2.2

**Problem statement.** Consider the following rules, which define the judgment $\text{hgt}(t;n)$ stating that the binary tree $t$ has *height* $n$.

$$
\text{hgt}(\text{empty};\text{zero})
$$
$$
\displaystyle\frac{\text{hgt}(t_1;n_1) \quad \text{hgt}(t_2;n_2) \quad \max(n_1;n_2;n)}{\text{hgt}(\text{node}(t_1;t_2); \text{succ}(n))}
$$

Prove that the judgment $\text{hgt}$ defines a function from trees to natural numbers.

<details>

<summary>Solution</summary>



- Existence $(*)$: For every $t\ \text{tree}$, there exists $h$ such that $\text{hgt}(t;h)$.
- For $t = \text{empty}$, this is trivial that $n = \text{zero}$, so $(*)$ holds.
- For $t = \text{node}(t_1;t_2)$ such that $t_1\ \text{tree}$ and $t_2\ \text{tree}$.

By the induction hypothesis, there exists $n_1\ \text{nat}$ and $n_2\ \text{nat}$ such that $\text{hgt}(t_1;n_1)$ and $\text{hgt}(t_2;n_2)$.

By **Exercise 2.1**, there exists $n\ \text{nat}$ such that $\max(n_1;n_2;n)$.

By definition, $\text{hgt}(t;\text{succ}(n))$.

- Uniqueness $(**)$: For every $t\ \text{tree}$, if $\text{hgt}(t;h)$ and $\text{hgt}(t;h')$, then $h = h'$.

Similar to $(*)$.
</details>

## Exercise 2.3

**Problem statement.** Given an inductive definition of *ordered variadic trees* whose nodes have a finite, but variable, number of children with a specified left-to-right ordering among them. Your solution should consist of a simultaneous definition of two judgments:

- $t\ \text{tree}$, stating that $t$ is a variadic tree.
- $f\ \text{forest}$, stating that $f$ is a "forest" (finite sequence) of variadic trees.
<details>
<summary>Solution</summary>



$$
\displaystyle\frac{}{\text{empty}\ \text{tree}}
$$
$$
\displaystyle\frac{}{\text{nil}\ \text{forest}}
$$
$$
\displaystyle\frac{t\ \text{tree} \quad f\ \text{forest}}{\text{cons}(t;f)\ \text{forest}}
$$
$$
\displaystyle\frac{f\ \text{forest}}{\text{node}(f)\ \text{tree}}
$$
</details>

## Exercise 2.4

**Problem statement.** Give an inductive definition of the height of a variadic tree of the kind defined in **Exercise 2.3**.

- Your definition should make use of an auxiliary judgment defining the height of a forest of variadic trees.
- It will be defined simultaneously with the height of a variadic tree.

Show that the two judgments so defined each define a function.

- Solution (incomplete)
- Definition

$$
\displaystyle\frac{}{\text{tree\_hgt}(\text{empty};\text{zero})}
$$
$$
\displaystyle\frac{}{\text{forest\_hgt}(\text{nil};\text{zero})}
$$
$$
\displaystyle\frac{\text{tree\_hgt}(t;n) \quad \text{forest\_hgt}(f;m)}{\text{forest\_hgt}(\text{cons}(t;f);\max(n;m))}
$$
$$
\displaystyle\frac{\text{forest\_hgt}(f;n)}{\text{tree\_hgt}(\text{node}(f);\text{succ}(n))}
$$
        

## Exercise 2.5

**Problem statement.** Give an inductive definition of the *binary natural numbers*, which are either:

- Zero
- Twice a binary number
- One more than twice a binary number

The size of such a representation is logarithmic, rather than linear, in the natural number it represents.

<details>

<summary>Solution</summary>



$$
\displaystyle\frac{}{\text{zero}\ \text{bin}}
$$
$$
\displaystyle\frac{b\ \text{bin}}{\text{twice}(b)\ \text{bin}}
$$
$$
\displaystyle\frac{b\ \text{bin}}{\text{twice\_plus\_one}(b)\ \text{bin}}
$$
</details>

## Exercise 2.6

**Problem statement.** Give an inductive definition of addition of binary natural numbers as defined in **Exercise 2.5**.

- **Hint:** Proceed by analyzing both arguments to the addition, and make use of an auxiliary function to compute the successor of a binary number.
- **Hint:** Alternatively, define both the sum and the sum-plus-one of two binary numbers mutually recursively.
- Solution (incomplete)
- Definition

$$
\displaystyle\frac{\text{sum}(b_1;b_2;b_3)}{\text{sum}(b_2;b_1;b_3)}
$$
$$
\displaystyle\frac{\text{sum\_plus\_one}(b_1;b_2;b_3)}{\text{sum\_plus\_one}(b_2;b_1;b_3)}
$$
$$
\displaystyle\frac{}{\text{sum}(\text{zero};\text{zero};\text{zero})}
$$
$$
\displaystyle\frac{}{\text{sum\_plus\_one}(\text{zero};\text{zero};\text{twice\_plus\_one}(\text{zero}))}
$$
$$
\displaystyle\frac{\text{sum}(b_1;b_2;b_3)}{\text{sum}(\text{twice}(b_1);\text{twice}(b_2);\text{twice}(b_3))}
$$
$$
\displaystyle\frac{\text{sum}(b_1;b_2;b_3)}{\text{sum}(\text{twice\_plus\_one}(b_1);\text{twice}(b_2);\text{twice\_plus\_one}(b_3))}
$$
$$
\displaystyle\frac{\text{sum\_plus\_one}(b_1;b_2;b_3)}{\text{sum}(\text{twice\_plus\_one}(b_2);\text{twice\_plus\_one}(b_1);\text{twice}(b_3))}
$$
$$
\displaystyle\frac{\text{sum\_plus\_one}(b_1;b_2;b_3)}{\text{sum\_plus\_one}(\text{twice\_plus\_one}(b_1);\text{twice}(b_2);\text{twice}(b_3))}
$$
$$
\displaystyle\frac{\text{sum}(b_1;b_2;b_3)}{\text{sum\_plus\_one}(\text{twice}(b_1);\text{twice}(b_2);\text{twice\_plus\_one}(b_3))}
$$
$$
\displaystyle\frac{\text{sum\_plus\_one}(b_1;b_2;b_3)}{\text{sum\_plus\_one}(\text{twice\_plus\_one}(b_1);\text{twice\_plus\_one}(b_2);\text{twice\_plus\_one}(b_3))}
$$

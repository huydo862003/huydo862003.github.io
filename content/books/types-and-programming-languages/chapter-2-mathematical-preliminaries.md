---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Chapter 2. mathematical preliminaries
author: Benjamin C. Pierce
date: ""
journey: plt
tags: []
concepts:
  - powerset
  - countable-set
  - transitive-closure
  - reflexive-transitive
  - preorder
  - partial-order
  - equivalence
  - principle-of-ordinary-induction
  - principle-of-complete-induction
  - lexicographic-order-principle-of-lexicographic-induction
  - lexicographic-order
parent: types-and-programming-languages
children: []
---

# Sets, Relations, and Functions

### **Sets and Numbers**

- **Standard notation**:
    - Use $\{...\}$ for **explicit lists** or **comprehension** (e.g., $\{x \in S \mid ...\}$).
    - $\emptyset$ denotes the **empty set**.
    - $S \setminus T$ denotes **set difference** (elements in $S$ but not in $T$).
    - $| S |$ denotes the **size of set** $S$.
    - $\mathcal{P}(S)$ is the **powerset** (set of all subsets) of $S$.
- **Natural numbers ($\mathbb{N}$)**: The set $\{0, 1, 2, ...\}$.
- **Countable**: A set is countable if it has a one-to-one correspondence with $\mathbb{N}$.

### **Relations**

- **n-place relation**: An n-ary relation.
- **Predicate**: A one-place (unary) relation on a set $S$.
    
    Written $P(s)$ or $s \in P$ regarding $P$ as a function mapping to truth values.
    
- **Binary relation**: A two-place relation on sets $S$ and $T$.
    
    Often written $s\,R\,t$ instead of $(s, t) \in R$.
    
- **Mixfix syntax**: For readability, relations with 3+ places often use symbols separating elements to form the name (e.g., $\Gamma \vdash s : T$).
- **Domain & Codomain**:
    - **Domain ($dom(R)$)**: The set of elements $s \in S$ such that $(s,t) \in R$ for some $t$.
    - **Codomain/Range ($range(R)$)**: The set of elements $t \in T$ such that $(s,t) \in R$ for some $s$.
- **Preservation**: A predicate $P$ is **preserved** by a relation $R$ if $s\, R\, s'$ and $P(s)$ implies $P(s')$.

### **Functions**

- **Partial function**: A relation $R$ where $(s, t_1) \in R$ and $(s, t_2) \in R$ implies $t_1 = t_2$.
    - **Defined**: Written $f(x)\downarrow$ means $x \in dom(f)$.
    - **Undefined**: Written $f(x)\uparrow$ or $f(x) =\ \perp$ means $x \notin dom(f)$.
- **Total function**: A partial function where $dom(R) = S$.
- **Failure**: Distinct from divergence.
    
    Formally, a function that may fail maps $S \to T \cup \{fail\}$.
    

# Ordered sets

### **Properties of binary relations**

Given a relation $R$ on set $S$:

- **Reflexive**: $s\, R\, s$ for all $s \in S$.
- **Symmetric**: $s\, R\, t$ implies $t\, R\, s$.
- **Transitive**: $s\, R\, t$ and $t\, R\, u$ implies $s\, R\, u$.
- **Antisymmetric**: $s\, R\,t$ and $t\, R\, s$ implies $s = t$.

### **Types of orders**

- **Preorder**: A relation that is **reflexive** and **transitive**.
    - Notation: Often written $\le$ or $\lesssim$.
    - Strict inequality ($s < t$): Means $s \le t \land s \neq t$.
- **Partial order**: A preorder that is also **antisymmetric**.
- **Total order**: A partial order where for every $s, t$, either $s \le t$ or $t \le s$.
- **Equivalence**: A relation that is **reflexive**, **transitive**, and **symmetric**.

### **Bounds and Closures**

- **Join (Least upper bound $\lor$)**: An element $j$ is the join of $s$ and $t$ if $s \le j$, $t \le j$, and $j$ is less than or equal to any other upper bound $k$.
- **Meet (Greatest lower bound $\land$)**: An element $m$ is the meet of $s$ and $t$ if $m \le s$, $m \le t$, and $m$ is greater than or equal to any other lower bound $n$.
- **Closures**:
    - **Reflexive closure**: The smallest reflexive relation containing $R$.
    - **Transitive closure ($R^+$)**: The smallest transitive relation containing $R$.
    - **Reflexive and transitive closure ($R^*$)**: The smallest relation containing $R$ that is both reflexive and transitive.

### **Chains and well-foundedness**

- **Decreasing chain**: A sequence $s_1, s_2, ...$ where $s_{i+1} < s_i$.
- **Well-founded**: A **preorder** is well-founded if it contains **no infinite decreasing chains**.
    - *Example*: Standard order on $\mathbb{N}$ is well-founded; standard order on integers is not.

# Sequences

- **Notation**: Elements are separated by commas (e.g., $3, 2, 1$).
- **Cons and Append**: The comma serves as both "cons" (adding an element) and "append" (joining sequences).
    - *Example*: If $a = 3,2,1$, then $0,a$ is $0,3,2,1$.
- **Range**: $1..n$ abbreviates the sequence from $1$ to $n$.
- **Length**: $| a |$ denotes the length of sequence $a$.
- **Empty sequence**: Written as $\epsilon$ or a blank.
- **Permutation**: A sequence containing the same elements as another, possibly in a different order.

# Induction

### **Induction on natural numbers**

- Axiom: **Principle of ordinary induction**
    
    If $P(0)$ holds, and $P(i) \implies P(i+1)$ for all $i$, then $P(n)$ holds for all $n$.
    
- Axiom: **Principle of complete induction**
    
    If showing $P(n)$ is possible assuming $P(i)$ for all $i < n$, then $P(n)$ holds for all $n$.
    

### **Lexicographic induction**

- **Lexicographic order**: On pairs of numbers, $(m,n) \le (m', n')$ iff $m < m'$ OR ($m = m'$ and $n \le n'$).
- Axiom: **Principle of lexicographic induction**
    
    If showing $P(m, n)$ is possible assuming $P(m', n')$ for all $(m', n') < (m, n)$, then $P(m, n)$ holds for all pairs.
    
- **Usage**: Generalized to triples, 4-tuples, etc. Useful for nested inductions.

---

# Exercises

## **Exercise 2.2.6**

**Problem**: Suppose we are given a relation $R$ on a set $S$. Define the relation $R^{\prime}$ as follows:

$R^{\prime} = R \cup \{(s,s) \mid s \in S\}$

That is, $R^{\prime}$ contains all the pairs in $R$ plus all pairs of the form $(s,s)$ .

**Task:** Show that $R^{\prime}$ is the reflexive closure of $R$.

<details>

<summary>Solution</summary>



Take $R''$ to be the reflexive closure of $R$.

By definition:

- $R''$ is reflexive.
- $R \subseteq R''$.
- For any reflexive relation $S$ such that $R \subseteq S$, we have $R'' \subseteq S$.

By the problem statement, $R'$ is reflexive and $R \subseteq R'$.

Therefore, $R'' \subseteq R'$.

Now, it suffices to show that $R' \subseteq R''$.

Take an element $x \in R'$.

- If $x \in R$, then $x \in R''$.
- If $x = (s,s)$ for some $s \in S$, then $x \in R''$ because $R''$ is reflexive.

Therefore, $R' \subseteq R''$.

In conclusion, $R' \equiv R''$ or $R'$ is the reflexive closure of $R$.
</details>

## **Exercise 2.2.7**

**Problem**: Here is a more constructive definition of the transitive closure of a relation $R$. First, we define the following sequence of sets of pairs:

- $R_{0} = R$
- $R_{i+1} = R_{i} \cup \{(s,u) \mid \text{for some } t, (s,t) \in R_{i} \text{ and } (t,u) \in R_{i}\}$

That is, we construct each $R_{i+1}$ by adding to $R_{i}$ all the pairs that can be obtained by "one step of transitivity" from pairs already in $R_{i}$. Finally, define the relation $R^{+}$ as the union of all the $R_{i}$: $R^{+} = \bigcup_{i} R_{i}$.

**Task:** Show that this $R^{+}$ is really the transitive closure of $R$-i.e., that it satisfies the conditions given in Definition 2.2.5.

- Problem
    
    Take $R'$ to be the transitive closure of $R$.
    
    By definition:
    
    - $R'$ is transitive.
    - $R \subseteq R'$.
    - For any transitive relation $S$ such that $R \subseteq S$, we have $R' \subseteq S$.
    - Prove that $R^+$ is transitive
        
        Suppose there exist $s, r, t$ such that $(s, r) \in R^+$ and $(r, t) \in R^+$ but $(s, t) \notin R^+$.
        
        Because $(s, r) \in R^+$, there exists $i_0$ such that $(s, r) \in R_{i_0}$.
        
        Similarly, there exists $i_1$ such that $(r, t) \in R_{i_1}$.
        
        Therefore, we have $(s, r)\in R_{\min{i_0, i_1}}$ and $(r, t)\in R_{\min{i_0, i_1}}$. Then, $(s,t) \in R_{\min{i_0, i_1} + 1} \subseteq R^+$. This is a contradiction.
        
    - It's obvious that $R \subseteq R^+$.
    - Therefore, $R' \subseteq R^+$.
    - Prove that $R^+ \subseteq R'$
        
        It's obvious that $R_0 \equiv R \subseteq R'$.
        
        Suppose for $R_i \subseteq R'$ for some $i\ge 0$.
        
        We will prove that $R_{i+1} \subseteq R'$. This is trivial.
        
        By induction, $R_i \subseteq R'$ for any $i \ge 0$.
        
        Therefore, $R^+ \subseteq R'$.
        
    - In conclusion, $R^+ \equiv R'$.

## **Exercise 2.2.8**

**Problem:** Suppose $R$ is a binary relation on a set $S$ and $P$ is a predicate on $S$ that is preserved by $R$.

**Task:** Show that $P$ is also preserved by $R^{*}$ (the reflexive and transitive closure of $R$).

- Problem
    
    Because $P$ is a predicate on $S$ that is preserved by $R$: For any $r, t \in S$ such that $r\, R\, t$, we have $P(r) \implies P(t)$.
    
    Take $R^{ref}$ to be the reflexive closure of $R$.
    
    Then, $R^*$ is the transitive closure of $R^{ref}$.
    
    Assume $r, t \in S$ such that $r\,R^*\,t$.
    
    - If $r\,R\,t$, it's trivial that $P$ is preserved.
    - If $r\not R\, t$ but $r\, R^{ref}\, t$, then $r=t$. Therefore, $P$ is also preserved.
    - If $r\not R^{ref}\, t$ but $r\, R^{*}\, t$, that means $r\, R_i\, t$ for some $i \ge 0$, with $R_i$ as defined in the previous exercise.
        
        Assume $i$ is smallest such number.
        
        - $i$ must not be $0$, else we would have $r\, R^{ref}\, t$, a contradiction.
        - Assume that if $r_i\, R_i\,t_i$ then $P(r_i) \implies P(t_i)$.
            
            We will prove that if $r_{i+1}\, R_{i+1}\,t_{i+1}$ then $P(r_{i+1}) \implies P(t_{i+1})$.
            
            By assumption, $r_{i+1} \not R_i\, t_{i+1}$.
            
            Therefore, there exists $s$ such that $r_{i+1}\, R_i\, s$ and $s\, R_i\, t_{i+1}$.
            
            By the induction hypothesis, we have $P(r_{i+1}) \implies P(s)$ and $P(s) \implies P(t_{i+1})$.
            
            It follows that, $P(r_{i+1}) \implies P(t_{i+1})$.
            
            By induction, if $r\, R_i\, t$ for any $i$, we have $P(r) \implies P(t)$.
            
    
    This concludes our proof.

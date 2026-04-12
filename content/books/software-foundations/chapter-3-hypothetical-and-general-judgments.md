---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Chapter 3. hypothetical and general judgments"
author: Benjamin C. Pierce et al.
date: ""
journey: plt
tags:
  - PLT
  - chapter
concepts: []
parent: logical-foundations
children: []
---

- A Hypothetical judgment expresses an Entailment between one or more Hypothesises and a Conclusion.
    
    → Two forms of Entailment:
    
    - Derivability.
    - Admissibility.
    
    → Both differ in that Derivability is Stable under extension with new rules, but Admissibility is not.
    
- A General judgment expresses the Universality or Genericity of a Judgment.
    
    → Two forms of General judgment:
    
    - [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment).
        
        The generic judgment expresses generality with respect to all substitution instances for variables in a judgment.
        
    - [Parametric (general) judgment](/journeys/plt/concepts/parametric-general-judgment).
        
        The parametric judgment expresses generality with respect to renamings of symbols.
        

# Hypothetical judgments

- The Hypothetical judgment arranges the rules for expressing the Validity of a Conclusion **conditional** on the Validity of one or more Hypothesises.
- There are two forms of Hypothetical judgments:
    
    → Differ according to **the sense** in which the Conclusion is **conditional** on the Hypothesises.
    
    → One is stable under extension with more rules, and the other is not.
    

## Derivability

- Consider a given set $\mathcal{R}$ of Rules.
- The Derivability judgment is written $J_1,\dots,J_k \vdash_\mathcal{R} K$, where $J_i$ and $K$ are Basic judgments.
- Such a Derivability judgment means that we may derive $K$ from the Expansion $\mathcal{R} \cup \{J_1, \dots, J_k\}$ of the rules $\mathcal{R}$ with the Axioms:
    
    $$
    \displaystyle\frac{}{J_1} \quad \dots \quad \displaystyle\frac{}{J_k}
    $$
    
    - The Hypothesises, or Antecedents, of the judgment, $J_1, \dots , J_k$ as "temporary axioms".
    - The Conclusion, or Consequents are derived by composing rules in $\mathcal{R}$.
- A set of finite Basic judgments is usually denoted as a capital Greek letter, such as $\Gamma$ or $\Delta$.
- $\mathcal{R}\cup \Gamma$  is taken to mean the Expansion of $\mathcal{R}$ with additional axioms with judgments in $\Gamma$ as the Consequents.
- The Judgment $\Gamma \vdash_{\mathcal{R}} K$ means that $K$ is Derivable from rules $\mathcal{R} \cup \Gamma$.
    
    The Judgment $\vdash_\mathcal{R} \Gamma$ means that $\vdash_\mathcal{R} J$ for each $J$ in $\Gamma$.
    
- An equivalent way of defining $J_1, \dots, J_n \vdash_\mathcal{R} J$ is to say that the rule
    
    $$
    \displaystyle\frac{J_1\ \dots\ J_n}{J}
    $$
    
    is Derivable from $\mathcal{R}$ - there is a derivation of $J$ composed of the rules in $R$ augmented by treating $J_1, \dots , J_n$ as axioms.
    
- Derivability is Stable under extension with new rules.

### Stability

**Theorem.** If $\Gamma \vdash_\mathcal{R} J$, then $\Gamma \vdash_{\mathcal{R}\cup\mathcal{R}'} J$.

<details>

<summary>Proof</summary>


Any derivation of $J$ from $R \cup \Gamma$  is also a derivation from $(R \cup R') \cup \Gamma$, because any rule in $R$ is also a rule in $R \cup R'$.


</details>

### Structural property

- Reflexivity: Every judgment is a consequence of itself - $\Gamma, J \vdash_\mathcal{R} J$. Each hypothesis justifies itself as a Conclusion.
- Weakening: If $\Gamma \vdash_\mathcal{R} J$, then  $\Gamma, K \vdash_\mathcal{R} J$. Entailment is not influenced by un-exercised options.
- Transitivity: If $\Gamma, K \vdash_\mathcal{R} J$ and $\Gamma \vdash_\mathcal{R} K$, then $\Gamma \vdash_\mathcal{R} J$. If we replace an axiom by a derivation of it, the result is a derivation of its consequent without that hypothesis.

## Admissibility

- Admissibility, usually written as $\Gamma \models_\mathcal{R} J$, is a weaker form of Hypothetical judgment stating that $\vdash_\mathcal{R} \Gamma$ implies $\vdash_\mathcal{R} J$.
    
    That is, the conclusion $J$ is derivable from rules $\mathcal{R}$ when the assumptions $\Gamma$ are all derivable from rules $\mathcal{R}$.
    
    In particular, if any of the hypotheses are not derivable relative to $\mathcal{R}$, then the judgment is **vacuously true**.
    
- An equivalent way to define the judgment $J_1, \dots , J_n \models_\mathcal{R} J$ is to state that the rule
    
    $$
    \displaystyle\frac{J_1\ \dots\ J_n}{J}
    $$
    
    is **admissible** relative to the rules in $\mathcal{R}$.
    
    Given any derivations of $J_1, \dots, J_n$ using the rules in $\mathcal{R}$, we may build a derivation of $J$ using the rules in $\mathcal{R}$.
    
- Example
    
    The Admissibility judgment
    
    $$
    \text{succ}(a)\ \text{even} \models a\ \text{odd}
    $$
    
    is valid.
    
    Reason: Any derivation of $\text{succ}(a)\ \text{even}$ from rules must contain a sub-derivation of $a\ \text{odd}$ from the same rules, which justifies the conclusion.
    

### Unstability

- The admissibility judgment is not stable under extension to the rules.
- Counterexample
    
    If we enrich the original rules:
    
    $$
    \displaystyle\frac{}{\text{zero}\ \text{even}}
    $$
    \displaystyle\frac{n\ \text{even}}{ \text{succ}(n)\ \text{odd}}
    $$
    \displaystyle\frac{n\ \text{odd}}{\text{succ}(n)\ \text{even}}
    $$
    
    with the following rule:
    
    $$
    \displaystyle\frac{}{\text{succ}(\text{zero})\ \text{even}}
    $$
    
    Then the rule $\text{succ}(a)\ \text{even} \models a\ \text{odd}$ is Inadmissible.
    

### Derivability as a stronger judgment than Admissibility

**Theorem.** If $\Gamma \vdash_\mathcal{R} J$, then $\Gamma \models_\mathcal{R} J$.

<details>

<summary>Proof</summary>


Repeated application of the transitivity of derivability shows that if $\Gamma \vdash_\mathcal{R} J$ and $\vdash_\mathcal{R} \Gamma$, then $\vdash_\mathcal{R} J$ .

- Counterexample to: If $\Gamma \models_\mathcal{R} J$, then $\Gamma \vdash_\mathcal{R} J$.

This amounts to showing an instance of $\mathcal{R}$, $\Gamma$ and $J$ such that:

- $\Gamma \models_\mathcal{R} J$, or If $\vdash_\mathcal{R} \Gamma$ then $\vdash_\mathcal{R} J$.
- $\Gamma \not\vdash_\mathcal{R} J$.

We can take $\mathcal{R}$ to contain:

$$
\displaystyle\frac{}{\text{zero}\ \text{even}}
$$
\displaystyle\frac{n\ \text{even}}{ \text{succ}(n)\ \text{odd}}
$$
\displaystyle\frac{n\ \text{odd}}{\text{succ}(n)\ \text{even}}
$$

We can take $\Gamma$ to contain:

$$
\text{succ}(\text{zero})\ \text{even}
$$

We can take $J$ to be: $\text{zero}\ \text{odd}$.


</details>

### Interpretation of an admissibility evidence

- Evidence for admissibility can be thought of as a mathematical function transforming derivations $\triangledown_1, \dots, \triangledown_n$ of the hypotheses into a derivation $\triangledown$ of the consequent.

### Structural property

- Reflexivity: If $J$ is derivable from the original rules, then $J$ is derivable from the original rules: $J \models_\mathcal{R} J$.
- Weakening: If $J$ is derivable from the original rules assuming that each of the judgments in $\Gamma$ are derivable from these rules, then $J$ must also be derivable assuming that $\Gamma$ and $K$ are derivable from the original rules: if  $\Gamma \models_\mathcal{R} J$, then $\Gamma, K \models_\mathcal{R} J$.
- Transitivity: If $\Gamma, K \models_\mathcal{R} J$ and $\Gamma \models_\mathcal{R} K$, then $\Gamma \models_\mathcal{R} J$. If the judgments in $\Gamma$ are derivable, so is $K$, by assumption, and hence so are the judgments in $\Gamma, K$, and hence so is $J$.

# Hypothetical inductive definitions

- Hypothetical inductive definitions enrich standard Inductive definitions by allowing rules where the Premises and Conclusions are Derivability judgments.
- This structure introduces two types of hypotheses:
    - Global hypothesises ($\Gamma$): In effect at the point where the Rule is applied.
    - **Local hypothesis**es ****($\Gamma_i$): Specific only to the Derivation of a particular Premise.
- A Hypothetical rule takes the following explicit form:
    
    $$
    \frac{\Gamma\ \Gamma_1 \vdash J_1 \quad \dots \quad \Gamma\ \Gamma_n \vdash J_n}{\Gamma \vdash J}
    $$
    
    The Hypothesises $\Gamma$ are the Global hypothesises of the Rule.
    
    The Hypothesises $\Gamma_i$ are the Local hypothesises of the $i$th Premise or the Rule.
    
    - **Interpretation:** $J$ is a Derivable consequence of $\Gamma$ if, for every Premise $i$, $J_i$ is a Derivable consequence of $\Gamma$ augmented by the local hypotheses $\Gamma_i$.
    - **Context switch:** Deriving a Premise involves a "context switch" where the Global hypothesises are extended by the Local hypothesises of that Premise.

## Uniformity & Implicit form

- Rules in a Hypothetical inductive definition **must** be Uniform, meaning **they apply in *all* global Context**s.
- Because of this Uniformity, the global Context $\Gamma$ is often suppressed, leading to the Implicit form:
    
    $$
    \frac{\Gamma_1 \vdash J_1 \quad \dots \quad \Gamma_n \vdash J_n}{J}
    $$
    
    \to Implicit understanding: The rule applies for any choice of Global hypothesises.
    

## Structurality of judgments

- A Hypothetical inductive definition \to An ordinary Inductive definition of a Formal derivability judgment $\Gamma \vdash J$ consisting of:
    - A finite set of Basic judgments $\Gamma$.
    - A Basic judgment $J$.
- A set of Hypothetical rules $\mathcal{R}$ defines the **strongest** Formal derivability judgment that is Structural and [Closed (under)](/journeys/plt/concepts/closed-under) Uniform rules $\mathcal{R}$.
- Structurality means that the Formal derivability judgment must be closed under the following rules:
    - Reflexivity:
        
        $$
        \displaystyle\frac{}{\Gamma, J \vdash J}
        $$
        
    - Weakening:
        
        $$
        \displaystyle\frac{\Gamma \vdash J}{\Gamma, K \vdash J}
        $$
        
    - Transitivity:
        
        $$
        \displaystyle\frac{\Gamma \vdash K \quad \Gamma, K \vdash J}{\Gamma \vdash J}
        $$
        

## Hypothetical rule induction

- The principle of Hypothetical rule induction is simply standard Rule induction applied to the Formal derivability judgment.
- To show that a property $\mathcal{P}(\Gamma \vdash J)$ holds whenever $\Gamma \vdash_{\mathcal{R}} J$, one must show that $\mathcal{P}$ is closed under:
    1. **The rules of $\mathcal{R}$**: If $\mathcal{P}(\Gamma\ \Gamma_1 \vdash J_1)$ and \ldots and  $\mathcal{P}(\Gamma\ \Gamma_n \vdash J_n)$, then $\mathcal{P}(\Gamma \vdash J)$.
    2. **The structural rules**: The property must be preserved under Reflexivity, Weakening, and Transitivity.
- In practice, rather than proving the structural steps explicitly during induction, we typically prove that the structural rules are Admissible.
    - If rules are Uniform, Weakening and Transitivity are usually clearly admissible.
    - Reflexivity is usually postulated explicitly as a rule.

# General judgments

- General judgments codify the Rules for handling Variables in a Judgment.
- Variable: An unknown, ranging over a specified set of objects.
- A [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment) states that a Judgment holds for any choice of objects replacing designated variables in the judgment.
- A [Parametric (general) judgment](/journeys/plt/concepts/parametric-general-judgment)s codify the handling of Symbolic parameters, expressing generality over any choice of Fresh renamings of designated Symbols of a Judgment.
- $\Gamma^{\mathcal{U};\mathcal{X}}_\mathcal{R}J$ - $J$ is Derivable from $\Gamma$ according to Rules $\mathcal{R}$, with objects consisting of [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt)s over Symbols $\mathcal{U}$ and Variables $\mathcal{X}$.

- The concept of Uniformity of a Rule must be extended to require that rules be:
    - Closed under **renaming** and **substitution** for Variables.
    - Closed under **renaming** for Symbolic parameters.
    
    Formally:
    
    - If $\mathcal{R}$ is a set of rules containing a Free variable $x$ of Sort $s$, then it must also contain all possible substitution instances of [Abstract binding tree (ABT)](/journeys/plt/concepts/abstract-binding-tree-abt)s $a$ of Sort $s$ for $x$, including those that contain other Free variables.
    - If $\mathcal{R}$ contains Rules with a Symbolic parameter $u$, then it must contain all instances of that rule obtained by renaming $u$ of a sort to any $u'$ of the same Sort.
    
    \to Ruling out:
    
    - Stating a rule for a variable, without also stating it for all instances of that variable.
    - Stating a rule for a parameter without stating it for all possible renamings of that parameter.

## Generic derivability

- Generic derivability judgment is defined by:
    
    $$
    $\mathcal{Y}\ \vert \ \Gamma \vdash^\mathcal{X}_\mathcal{R}\ J\quad \text{iff} \quad \Gamma \vdash^{\mathcal{X}\mathcal{Y}}_\mathcal{R}J$
    $$
    
    where $\mathcal{Y} \cap \mathcal{X} = \empty$.
    
- Evidence for Generic derivability consists of a Generic derivation $\triangledown$ involving the Variables $\mathcal{X}\mathcal{Y}$.
    
    \to If the rules are Uniform, the choice of $\mathcal{Y}$ does not matter.
    
    - Example
        
        Given $\mathcal{R}$ as:
        
        $$
        \displaystyle\frac{}{\text{zero}\ \text{nat}}
        $$
        \displaystyle\frac{x\ \text{nat}}{\text{succ}(x)\ \text{nat}}
        $$
        
        The Generic derivation $\triangledown$:
        
        $$
        \displaystyle\frac{\displaystyle\frac{\displaystyle\frac{}{x\ \text{nat}}}{\text{succ}(x)\ \text{nat}}}{\text{succ}(\text{succ}(x))\ \text{nat}}
        $$
        
        is Evidence for the Judgment:
        
        $$
        x \ \vert  \ x\ \text{nat} \vdash^{\mathcal{X}}_\mathcal{R}\ \text{succ}(\text{succ}(x))\ \text{nat}
        $$
        
        provided $x \notin \mathcal{X}$.
        
- The Generic derivability judgment enjoys the following Structural property governing the behavior of Variables, provided that $\mathcal{R}$ is Uniform.
    - Proliferation:
        
        If $\mathcal{Y}\ \vert \ \Gamma \vdash^\mathcal{X}_\mathcal{R}\ J$, then $\mathcal{Y}, y\ \vert \ \Gamma \vdash^\mathcal{X}_\mathcal{R} J$.
        
    - Renaming:
        
        If $\mathcal{Y}, y\ \vert \ \Gamma \vdash^\mathcal{X}_\mathcal{R} J$, then $\mathcal{Y}, y'\ \vert \ [y \leftrightarrow y']\Gamma \vdash^\mathcal{X}_\mathcal{R}[y \leftrightarrow y']J$ for any $y' \notin \mathcal{XY}$.
        
    - Substitution:
        
        If $\mathcal{Y}, y\ \vert \ \Gamma \vdash^\mathcal{X}_\mathcal{R} J$ and $a \in \mathcal{B}[\mathcal{XY}]$, then $\mathcal{Y}\ \vert \ [a/y]\Gamma \vdash^\mathcal{X}_\mathcal{R}[a/y]J$.
        
- Remarks: To my understanding, $\mathcal{X}$ acts somewhat like free variables, and $\mathcal{Y}$ acts somewhat like bound variables.

## Parametric derivability

- [Parametric (general) judgment](/journeys/plt/concepts/parametric-general-judgment) is defined analogously like [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment), albeit by generalizing over Symbolic parameters, rather than Variables.
- [Parametric (general) judgment](/journeys/plt/concepts/parametric-general-judgment) is defined by:
    
    $$
    $\mathcal{V} \  \Vert \  \mathcal{Y}\ \vert  \ \Gamma \vdash^{\mathcal{U};\mathcal{X}}_{\mathcal{R}}\ J \quad \text{iff} \quad \mathcal{Y}\  \vert \ \Gamma^{\mathcal{UV};\mathcal{X}}_\mathcal{R}\ J$
    $$
    
    where $\mathcal{V} \cap \mathcal{U} = \empty$.
    
- Evidence for [Parametric (general) judgment](/journeys/plt/concepts/parametric-general-judgment) consists of a Derivation $\triangledown$ involving the symbols $\mathcal{V}$.
- Uniformity of $\mathcal{R}$ ensures that any choice of parameter names is as good as any other. Derivability is Stable under Renaming.

# Generic inductive definitions

- A Generic inductive definition admits Generic inductive definition in the Premises of rules.
    
    \to Augmenting the variables & the rules within those Premises.
    
- A Generic rule has the form:
    
    $$
    \displaystyle\frac{\mathcal{Y}\ \mathcal{Y}_1\ \vert  \ \Gamma\ \Gamma_1 \vdash J_1 \quad \dots \quad \mathcal{Y}\ \mathcal{Y}_n\  \vert \ \Gamma\ \Gamma_n\vdash J_n}{\mathcal{Y}\ \vert \ \Gamma \vdash J}
    $$
    
    - Global variables: $\mathcal{Y}$.
    - For each $1 \le i \le n$, Local variables of the $i$th Premise: $\mathcal{Y}_i$.
- Implicit form:
    
    $$
    \displaystyle\frac{\mathcal{Y}_1\ \vert  \ \Gamma_1 \vdash J_1 \quad \dots \quad \mathcal{Y}_n\  \vert \ \Gamma_n \vdash J_n}{J}
    $$
    
- A Generic inductive definition is an ordinary Inductive definition of a family of formal [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment)s of the form $\mathcal{Y}\ \vert \ \Gamma \vdash J$.
    
    Formal [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment)s are identified up to Renaming of Variables.
    
    \to The latter Judgment is treated as identical to the Judgment $\mathcal{Y}'\ \vert \ \hat{\rho}(\Gamma) \vdash \hat{\rho}(J)$ for any Renaming $\rho : \mathcal{Y} \leftrightarrow \mathcal{Y}'$.
    
- If $\mathcal{R}$ is a collection of Generic rules, we write $\mathcal{Y}\ \vert \ \Gamma \vdash_{\mathcal{R}} J$ to mean that the formal [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment) $\mathcal{Y}\ \vert \ \Gamma \vdash J$ is derivable from rules $\mathcal{R}$.
- When specialized to a set of Generic rules, the principle of Rule induction states that to show $\mathcal{P}(\mathcal{Y}\ \vert \ \Gamma \vdash J)$ when $\mathcal{Y}\ \vert  \Gamma \vdash_{\mathcal{R}} J$, it is sufficient to show that $\mathcal{P}$ is closed under the rules $\mathcal{R}$.
    
    If $\mathcal{P}(\mathcal{Y}\ \mathcal{Y}_1\ \vert  \ \Gamma\ \Gamma_1 \vdash J_1)\ \dots\ \mathcal{P}(\mathcal{Y}\ \mathcal{Y}_n\  \vert \ \Gamma\ \Gamma_n \vdash J_n)$ then $\mathcal{P}(\mathcal{Y}\ \vert \ \Gamma \vdash J)$.
    
    - The property $\mathcal{P}$ must respect Renamings of the Variables in a formal [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment).
- To ensure that a Formal generic judgment behaves like a [Generic (general) judgment](/journeys/plt/concepts/generic-general-judgment), the Structural rules are Admissible.
    
    $$
    \displaystyle\frac{}{\mathcal{Y}\ \vert \ \Gamma, J \vdash J} \tag{3.14a}
    $$
    \displaystyle\frac{\mathcal{Y}\ \vert  \ \Gamma \vdash J}{\mathcal{Y}\  \vert \ \Gamma, J' \vdash J} \tag{3.14b}
    $$
    \displaystyle\frac{\mathcal{Y}\ \vert  \ \Gamma \vdash J}{\mathcal{Y}, x\  \vert \ \Gamma \vdash J} \tag{3.14c}
    $$
    \displaystyle\frac{\mathcal{Y}, x'\ \vert  \ [x\leftrightarrow x']\Gamma \vdash [x \leftrightarrow x']J}{\mathcal{Y}, x\  \vert \ \Gamma \vdash J} \tag{3.14d}
    $$
    \displaystyle\frac{\mathcal{Y}\ \vert   \ \Gamma\vdash J\quad \mathcal{Y}\  \vert \ \Gamma, J \vdash J'}{\mathcal{Y}\ \vert \ \Gamma \vdash J'} \tag{3.14e}
    $$
    \displaystyle\frac{\mathcal{Y}, x\ \vert  \ \Gamma \vdash J \quad a \in \mathcal{B}[\mathcal{Y}]}{\mathcal{Y}\  \vert \ [a/x]\Gamma \vdash [a/x]J} \tag{3.14f}
    $$
    
    - The Admissibility of rule (3.14a) is in practice ensured by explicitly including it.
    - The Admissibility of rules (3.14b) and (3.14c) is assured if each of the generic rules is Uniform because we may:
        - Assimilate the added variable $x$ to the global variables $\mathcal{Y}$.
        - Assimilate the added hypothesis $J'$ to the global hypotheses $\Gamma'$.
    - The Admissibility of rule (3.14d) is ensured by the identification convention for the formal generic judgment.
    - Rule (3.14f) must be verified explicitly for each inductive definition.
- Parametric inductive definition is similar to generic inductive definition.

# Notes

- **Foundational roots**
    - The concepts of entailment and generality are central to logic and programming languages.
    - Harper's formulation builds specifically on the work of **Martin-Lof (1983, 1987)** and **Avron (1991)**.
- **Contrast with AUTOMATH & LF**
    - **Unified Concept:** Systems like **AUTOMATH** and the **LF Logical Framework** consolidate hypothetical and general reasoning into a *single* concept.
    - **Arbitrary Nesting:** These systems allow for arbitrarily nested combinations of judgments (e.g., judgments about judgments).
- **Harper's distinction**
    - **Restricted structure:** Unlike LF, PFPL considers only **general hypothetical judgments** over *basic* judgment forms. It separates the machinery of entailment from the basic judgments.
    - Explicitly introduces **symbols** and **variables**, which were not present in the previous accounts (Martin-Lof/Avron).
- **Why symbols matter (Parametric Judgments)**
    - **Parametric judgments** are necessary to specify languages that allow the **dynamic creation of "new" objects**.

# Exercise

## Exercise 3.1

**Problem statement.** Combinator*s* are inductively defined by the rule set $\mathcal{C}$ given as follows:

$$
\displaystyle \frac{}{\mathsf{s} \ \text{comb}} \quad \tag{3.15a}
$$
\displaystyle\frac{}{\mathsf{k}\ \text{comb}} \quad \tag{3.15b}
$$
\displaystyle \frac{a_1 \text{ comb} \quad a_2 \text{ comb}}{\mathsf{ap}(a_1; a_2) \text{ comb}} \quad \tag{3.15c}
$$

Give an inductive definition of the *length* of a combinator defined as the number of occurrences of $\mathsf{s}$ and $\mathsf{k}$ within it.

<details>

<summary>Solution</summary>



</details>

</details>

    - Definition
        
        $$
        \displaystyle\frac{}{\text{len}(\mathsf{s};\text{succ(\text{zero})})}
        $$
        \displaystyle\frac{}{\text{len}(\mathsf{k};\text{succ(\text{zero})})}
        $$
        \displaystyle\frac{a_1\ \text{comb} \quad a_2\ \text{comb} \quad \text{len}(a_1; l_1) \quad \text{len}(a_2;l_2)}{\text{len}(\mathsf{ap}(a_1;a_2);\text{plus}(l_1;l_2))}
        $$
        
    - Existence
        
        For every $a\ \text{comb}$, there must exist $n\ \text{nat}$ such that $\text{len}(a; n)$.
        
        - For $a=\mathsf{s}$ and $a=\mathsf{k}$, it's obvious that $n = \text{succ}(\text{zero})$ is a witness.
        - Suppose that $n_1\ \text{nat}$ is a witness for $a_1\ \text{comb}$ and $n_2\ \text{nat}$ is a witness for $a_2\ \text{comb}$, then it's obvious that $\text{plus}(l_1;l_2)$ is a witness for $\mathsf{ap}(a_1;a_2)$.
    - Uniqueness
        
        For every $a\ \text{comb}$, if there exist two $n_1\ \text{nat}$ and $n_2\ \text{nat}$ such that $\text{len}(a;n_1)$ and $\text{len}(a;n_2)$, then $n_1 = n_2$.
        
        - For $a = \mathsf{s}$ and $a = \mathsf{k}$, it's obvious that $n = \text{succ}(\text{zero})$ is the unique value.
        - Suppose that $n_1\ \text{nat}$ is a witness for $a_1\ \text{comb}$ and $n_2\ \text{nat}$ is a witness for $a_2\ \text{comb}$, then it's obvious that $\text{plus}(l_1;l_2)$ is the unique value.



## Exercise 3.2

**Problem statement.** The general judgment

$$
x_1, \ldots, x_n \mid x_1 \text{ comb}, \ldots, x_n \text{ comb} \vdash_{\mathcal{C}} A \text{ comb}
$$

states that $A$ is a combinator that may involve the variables $x_1, \ldots, x_n$. Prove that if $x \mid x \text{ comb} \vdash_{\mathcal{C}} a_2 \text{ comb}$ and $a_1 \text{ comb}$, then $[a_1/x]a_2 \text{ comb}$ by induction on the derivation of the first hypothesis of the implication.

### Confusion and notes

Lifting & Hypothetical judgments.

- The core question:
    
    **If the base rules $\mathcal{C}$ (combinators) do not mention variables or contexts, how is it possible to derive a judgment that contains them?**
    
- For example:
    - The rule for $\mathsf{s}$ is just $\overline{\mathsf{s} \text{ comb}}$. It knows nothing about $x$.
    - We often need to prove things like $x \vdash \mathsf{ap}(\mathsf{s}; x)$.
- Where does the permission to use $x$ come from if not from the rules?
- For some variables $\mathcal{Y}$ and hypotheses $\Gamma$:
    - **Reflexivity**:
        
        $$
        \displaystyle\frac{}{\mathcal{Y}\ \vert \ \Gamma, J \vdash_\mathcal{C} J}
        $$
        
    - $\mathcal{Y} \ \vert \ \Gamma \vdash_\mathcal{C} J$ is defined to be equivalent to $\Gamma \vdash_\mathcal{C}^\mathcal{Y} J$, which in turn, means that with $\mathcal{Y}$ instantiated, $J$ is derivable using the rules $\Gamma \cup \mathcal{C}$.
        
        Because the rules in $\mathcal{C}$ holds regardless of instantiations of $\mathcal{Y}$ and $\Gamma$, we can lift each rule in $\mathcal{C}$ like this:
        
        $$
        \displaystyle \frac{\mathcal{Y}\ \vert  \ \Gamma \vdash a_1 \text{ comb} \quad \mathcal{Y}\  \vert \ \Gamma \vdash a_2 \text{ comb}}{\mathcal{Y}\ \vert \ \Gamma \vdash \mathsf{ap}(a_1; a_2) \text{ comb}}
        $$
<details>
<summary>Solution</summary>



After lifting, $\mathcal{C}$ becomes (minus the structural rules):

$$
\displaystyle \frac{}{\Gamma \vdash \mathsf{s} \ \text{comb}} \quad \tag{3.15a}
$$
\displaystyle \frac{}{\Gamma \vdash \mathsf{k} \ \text{comb}} \quad \tag{3.15b}
$$
\displaystyle \frac{\mathcal{Y}\ \vert  \ \Gamma \vdash a_1 \text{ comb} \quad \mathcal{Y}\  \vert \ \Gamma \vdash a_2 \text{ comb}}{\mathcal{Y}\ \vert \ \Gamma \vdash \mathsf{ap}(a_1; a_2) \text{ comb}} \quad \tag{3.15c}
$$

By the problem statement, I assume that:

There is a derivation $\triangledown$ using the rules $\mathcal{C}$ with a conclusion of $x\ \vert \ x\ \text{comb} \vdash_\mathcal{C} a_2\ \text{comb}$.

Consider the last rule applied in $\triangledown$ for each of the above rule, then maybe try to modify the derivation to conclude $\mathsf{ap}(a_1;a_2)$.
</details>
</details>

## Exercise 3.3

**Problem statement.** *Conversion*, or *equivalence*, of combinators is expressed by the judgment $A \equiv B$ defined by the rule set $\mathcal{E}$ extending $\mathcal{C}$ as follows:

$$
\frac{a \text{ comb}}{a \equiv a} \tag{3.16a}
$$
\frac{a_2 \equiv a_1}{a_1 \equiv a_2} \tag{3.16b}
$$
\frac{a_1 \equiv a_2 \quad a_2 \equiv a_3}{a_1 \equiv a_3} \tag{3.16c}
$$
\frac{a_1 \equiv a_1' \quad a_2 \equiv a_2'}{a_1\ a_2 \equiv a_1'\ a_2'} \tag{3.16d}
$$
\frac{a_1 \text{ comb} \quad a_2 \text{ comb}}{\mathsf{k} \, a_1 \, a_2 \equiv a_1} \tag{3.16e}
$$
\frac{a_1 \text{ comb} \quad a_2 \text{ comb} \quad a_3 \text{ comb}}{\mathsf{s} \, a_1 \, a_2 \, a_3 \equiv (a_1 \, a_3)\ (a_2 \, a_3)} \tag{3.16f}
$$

The no-doubt mysterious motivation for the last two equations will become clearer in a moment. For now, show that

$$
x \mid x \text{ comb} \vdash_{\mathcal{C} \cup \mathcal{E}} \mathsf{s} \, \mathsf{k} \, \mathsf{k} \, x \equiv x
$$

**Note:** The combinator $\text{ap}(a_1 ;a_2 )$ is written $a_1\ a_2$ for short, left-associatively when used in succession.

<details>

<summary>Solution</summary>



After lifting, the ruleset $\mathcal{E}$ becomes:

$$
\frac{\mathcal{Y}\ \vert \ J \vdash  x\ \text{comb}}{x \equiv x} \tag{3.16a}
$$
\frac{\mathcal{Y}\ \vert \ J \vdash x_2 \equiv x_1}{x_1 \equiv x_2} \tag{3.16b}
$$
\frac{\mathcal{Y}\ \vert  \ J \vdash x_1 \equiv x_2 \quad \mathcal{Y}\  \vert \ J \vdash x_2 \equiv x_3}{\mathcal{Y}\ \vert \ J \vdash x_2 \equiv x_3} \tag{3.16c}
$$
\frac{\mathcal{Y}\ \vert  \ J \vdash x_1 \equiv x_1' \quad \mathcal{Y}\  \vert \ J \vdash  x_2 \equiv x_2'}{\mathcal{Y}\ \vert \ J \vdash x_1\ x_2 \equiv x_1'\ x_2'} \tag{3.16d}
$$
\frac{\mathcal{Y}\ \vert  \ J \vdash x_1 \text{ comb} \quad \mathcal{Y}\  \vert \ J \vdash x_2 \text{ comb}}{\mathcal{Y}\ \vert \ J \vdash \mathsf{k} \, x_1 \, x_2 \equiv x_1} \tag{3.16e}
$$
\frac{\mathcal{Y}\ \vert  \ J \vdash x_1 \text{ comb} \quad \mathcal{Y}\  \vert \ J \vdash x_2 \text{ comb} \quad \mathcal{Y}\ \vert  \ J \vdash x_3 \text{ comb}}{\mathcal{Y}\  \vert \ J \vdash \mathsf{s} \, x_1 \, x_2 \, x_3 \equiv (x_1 \, x_3)\ (x_2 \, x_3)} \tag{3.16f}
$$

We'll prove that:

$$
x \mid x \text{ comb} \vdash_{\mathcal{C} \cup \mathcal{E}} \mathsf{s} \, \mathsf{k} \, \mathsf{k} \, x \equiv x.
$$
\displaystyle\frac{\displaystyle\frac{x\ \vert  \ x\ \text{comb} \vdash \mathsf{k}\ \text{comb} \quad x\  \vert \ x\ \text{comb} \vdash x\ \text{comb}}{x\ \vert  \ x\ \text{comb} \vdash \mathsf{s}\ \mathsf{k}\ \mathsf{k}\ x \equiv (\mathsf{k}\ x)\ (\mathsf{k}\ x)} \quad \displaystyle\frac{ x\  \vert  \  x\ \text{comb} \vdash \mathsf{x}\ \text{comb}}{ x\ \vert   \  x\ \text{comb} \vdash (\mathsf{k}\ x)\ \text{comb}}}{x\  \vert \ x\ \text{comb} \vdash \mathsf{s}\ \mathsf{k}\ \mathsf{k}\ x \equiv x}
$$
</details>
</details>

## Exercise 3.4

**Problem statement.** Show that if $x \mid x \text{ comb} \vdash_{\mathcal{C}} a \text{ comb}$, then there is a combinator $a'$, written $[x]a$ and called *bracket abstraction*, such that:

$$
x \mid x \text{ comb} \vdash_{\mathcal{C} \cup \mathcal{E}} a'\ x \equiv a
$$

Consequently, by Exercise 3.2, if $a'' \text{ comb}$, then:

$$
([x]a)\ a'' \equiv [a''/x]a
$$

**Hint:**

Inductively define the judgment:

$$
x \mid x \text{ comb} \vdash \text{abs}_x\ a \text{ is } a'
$$

where $x \mid x \text{ comb} \vdash a \text{ comb}$. Then argue that it defines $a'$ as a binary function of $x$ and $a$. The motivation for the conversion axioms governing $\mathsf{k}$ and $\mathsf{s}$ should become clear while developing the proof of the desired equivalence.

- Confusion point
    
    I thought $a' = [x]a \equiv \mathsf{k}\ a$ worked for all $a$ and $x$ & spent 1 hour wondering why this problem was nontrivial.
    
    It turns out, because $a'$ is a combinator, which means $\vdash a'\ \text{comb}$.
    
    If $a$ contains the variable $x$, then, $\not\vdash (\mathsf{k}\ a)\ \text{comb}$. It's only true that $x\ \vert \ x\ \text{comb} \vdash (\mathsf{k}\ a)\ \text{comb}$ .
    
<details>

<summary>Solution</summary>



We define $\text{abs}$ as:

$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \mathsf{s}\ \text{is}\ \mathsf{k}\ \mathsf{s}}
$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \mathsf{k}\ \text{is}\ \mathsf{k}\ \mathsf{k}}
$$
\displaystyle\frac{}{x\ y\ \vert \ x\ \text{comb} \ y\ \text{comb} \vdash \text{abs}_x\ y\ \text{is}\ \mathsf{k}\ y}
$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ x\ \text{is}\ \mathsf{s}\ \mathsf{k}\ \mathsf{k}\ x}
$$
\displaystyle\frac{x\ \vert  \ x\ \text{comb}\vdash \text{abs}_x\ a_1\ \text{is}\ a'_1 \quad x\  \vert \ x\ \text{comb}\vdash \text{abs}_x\ a_2\ \text{is}\ a'_2}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \text{ap}\  a_1\ a_2 \ \text{is}\ \mathsf{s}\ a_1'\ a_2'}
$$



## Exercise 3.5

**Problem statement.** Prove that bracket abstraction, as defined in Exercise 3.4, is *non-compositional* by exhibiting $a$ and $b$ such that $a \text{ comb}$ and

$$
x \, y \mid x \text{ comb} \, y \text{ comb} \vdash_{\mathcal{C}} b \text{ comb}
$$

such that: $[a/y]([x]b) \neq [x]([a/y]b)$

**Hint:** Consider the case that $b$ is $y$.

Suggest a modification to the definition of bracket abstraction that is *compositional* by showing under the same conditions given above that:

$$
[a/y]([x]b) = [x]([a/y]b)
$$

- Note

Because $a$ is a categorical judgment evaluated in an empty context, $a$ must be a closed combinator with no free variables, whereas $b$ is defined under a hypothetical judgment that explicitly permits variables.

<details>

<summary>Solution</summary>



- If  $b = y$, then:
- $[x]b = [x]y = \mathsf{k}\ y$.

\to LHS = $[a/y]([x]\ b) = [a/y](\mathsf{k}\ y) = \mathsf{k}\ a$.

- $[a/y]b = [a/y]y = a$.

\to RHS = $[x]([a/y]b) = [x]a$.


It's trivial that there exists an $a$ being some combination of $\mathsf{s}$ and $\mathsf{k}$ such that $\mathsf{k}\ a \neq [x]a$ (they are equivalent though).

- Intuition: To redefine a new bracket abstraction that is compositional in this context, it must at least be compositional when $b = y$.

My guts feeling here is to modify the fourth rule in the original ruleset.

Then LHS = $[a/y]([x]y)$ = $[x]a$ = RHS for all $a$ such that $\vdash a\ \text{comb}$.

- Start with $a = \mathsf{k}$.
- New definition:

$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \mathsf{s}\ \text{is}\ \mathsf{k}\ \mathsf{s}}
$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \mathsf{k}\ \text{is}\ \mathsf{k}\ \mathsf{k}}
$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ x\ \text{is}\ \mathsf{s}\ \mathsf{k}\ \mathsf{k}}
$$
\displaystyle\frac{}{x\ \vert \ x\ \text{comb}\ y\ \text{comb}\vdash \text{abs}_x\ y\ \text{is}\ }
\\
\displaystyle\frac{x\ \vert  \ x\ \text{comb}\vdash \text{abs}_x\ a_1\ \text{is}\ a'_1 \quad x\  \vert \ x\ \text{comb}\vdash \text{abs}_x\ a_2\ \text{is}\ a'_2}{x\ \vert \ x\ \text{comb}\vdash \text{abs}_x\ \text{ap}\  a_1\ a_2 \ \text{is}\ \mathsf{s}\ a_1'\ a_2'}
$$



## Exercise 3.6

**Problem statement.** Consider the set $\mathcal{B}[\mathcal{X}]$ of ABT's generated by the operators $\text{ap}$, with arity $(\text{Exp}, \text{Exp})\text{Exp}$, and $\lambda$, with arity $(\text{Exp}.\text{Exp})\text{Exp}$, and possibly involving variables in $\mathcal{X}$, all of which are of sort $\text{Exp}$.

Give an inductive definition of the judgment $b \text{ closed}$, which specifies that $b$ has no free occurrences of the variables in $\mathcal{X}$.

**Hint:** It is essential to give an inductive definition of the *hypothetical, general judgment*

$$
x_1, \dots, x_n \mid x_1 \text{ closed}, \dots, x_n \text{ closed} \vdash b \text{ closed}
$$

in order to account for the binding of a variable by the $\lambda$ operator.

The hypothesis that a variable is closed seems self-contradictory in that a variable obviously occurs free in itself. Explain why this is not the case by examining carefully the meaning of the hypothetical and general judgments.

<details>

<summary>Solution</summary>

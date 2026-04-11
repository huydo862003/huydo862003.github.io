---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Intuitionistic/Constructive logic"
description: "\\frac{A \\quad B}{A \\land B} & & (\\land\\text{-intro}) \\\\ \\\\"
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "formal-system"
  - "logic"
  - "syntax-grammar"
keywords:
  - "text"
  - "frac"
  - "aligned"
  - "quad"
  - "elim"
  - "intro"
  - "begin"
  - "land"
  - "end"
---

- Inference rules
    - Conjunction
        
        $$
\begin{aligned}
$$
\frac{A \quad B}{A \land B} & & (\land\text{-intro}) \\ \\
\qquad \frac{A \land B}{A} & &  (\land\text{-elim}_1) \\ \\
\qquad \frac{A \land B}{B} &  & (\land\text{-elim}_2)
\end{aligned}
$$
$$
        
    - Disjunction
        
        $$
\begin{aligned}
$$
\frac{A}{A \lor B} & & (\lor\text{-intro}_1) \\ \\
\frac{B}{A \lor B} & & (\lor\text{-intro}_2) \\\\
\frac{A \lor B \quad A \vdash C \quad B \vdash C}{C} & & (\lor\text{-elim})
\end{aligned}
$$
$$
        
    - Implication
        
        $$
\begin{aligned}
$$
\frac{A \vdash B}{A \to B} & & (\to\text{-intro}) \\ \\
\frac{A \to B \quad A}{B} & & (\to\text{-elim})
\end{aligned}
$$
$$
        
    - Universal quantification
        
        $$
\begin{aligned}
$$
\frac{P(x) \quad x \text{ fresh}}{\forall x.\, P(x)} & & (\forall\text{-intro}) \\ \\  \frac{\forall x.\, P(x)}{P(t)} & & (\forall\text{-elim})
\end{aligned}
$$
$$
        
    - Existential quantification
        
        $$
\begin{aligned}
$$
\frac{P(t)}{\exists x.\, P(x)} & & (\exists\text{-intro}) \\ \\ \frac{\exists x.\, P(x) \quad P(y) \vdash C \quad y \text{ fresh}}{C} & & (\exists\text{-elim})
\end{aligned}
$$
$$
        
    - Negation
        
        $$
\begin{aligned}
$$
\frac{A \vdash \bot}{\neg A} & & (\neg\text{-intro}) \\ \\
\frac{A \quad \neg A}{\bot} & & (\neg\text{-elim})
\end{aligned}
$$
$$
        
    - Absurdity
        
        $$
        \frac{\bot}{A} \quad (\bot\text{-elim})
        $$
        

**Pitfall.** The rules define which derivations are valid. They say nothing about meaning-that is the role of an interpretation such as BHK.

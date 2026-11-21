---
_type: PltPhase
_label: 'Phase 2 - formal language theory & parsing'
journey: fref("/01-programming-language-theory/index.td")
status: 'on hold'
order: 2
_ssg:
  show_in_sidebar: false
---

How syntax is defined and processed. Mostly depends on basic math and can be studied in parallel with phase 1, but semantically it feeds into compilers.

## Concepts

- Regular languages, context-free grammars, context-sensitive grammars
- Chomsky hierarchy & pumping lemmas
- Parsing algorithms (LL, LR, GLR, PEGs, GLL, Earley)
- Parser combinators vs. generator tools (yacc, bison, menhir, tree-sitter)
- Scannerless parsing & layout-sensitive languages (Haskell, Python)
- Fuzzing as a side-tool

## Dependency

Automata + Grammars -> Parsing algorithms -> Practical parsing tools

## Resources

- Hopcroft / Motwani / Ullman *Automata Theory* or Sipser *Theory of Computation* - regular/CFG/Chomsky hierarchy
- Grune & Jacobs *Parsing Techniques* - comprehensive parsing algorithms
- **PLP** - parsing chapters, lexical analysis, combinators vs. tools
- **Dragon** - LL/LR parsing in a compiler context; Menhir/ANTLR docs for hands-on
- tree-sitter docs & blog posts
- Papers / blog posts via SIGPLAN / HN on scannerless parsing and indentation sensitivity

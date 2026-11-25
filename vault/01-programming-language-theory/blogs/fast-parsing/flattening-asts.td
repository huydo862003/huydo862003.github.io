---
_type: Blog
_label: 'Flattening ASTs (and Other Compiler Data Structures)'
url: 'https://www.cs.cornell.edu/~asampson/blog/flattening.html'
journey: null
site: fref("/01-programming-language-theory/blogsites/adrian-sampson.td")
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/arena-allocator.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
  - fref("/01-programming-language-theory/02-concepts/region-based-memory-management.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
---

${fref("../../02-concepts/arena.td")}s are widespread, and a form of it is a great fit for compilers.

The author refers to the technique involving **arenas** as **data structure flattening**. The technique can be applied to any pointer-laden data structure, but is specificially applied to ASTs here:

- Each **arena** is a plain array, holding only objects of one type.
- Pointers are replaced with array indices into the arena.

::: note Advantages of the Approach
1. Performance: Due to better data locality.
2. Some side ergonomics benefits.
:::

## The Example Language

An **arithmetic expression** language:

- Literal integers.
- Four binary arithmetic operators: `+`, `-`, `*`, `/`.

## The Traditional AST Way

In Rust, here is the definition of program structures:

```rust
enum BinOp {
  Add,
  Sub,
  Mul,
  Div
}

enum Expr {
  Binary(BinOp, Box<Expr>, Box<Expr>), // Pointer here
  Literal(i64),
}
```

Interpreting is trivial:

```rust
impl Expr {
  fn interp(&self) -> i64 {
    match self {
      Expr::Binary(op, lhs, rhs) => {
        let lhs = lhs.interp();
        let rhs = rhs.interp();
        match op {
          BinOp::Add => lhs.wrapping_add(rhs),
          BinOp::Sub => lhs.wrapping_sub(rhs),
          BinOp::Mul => lhs.wrapping_mul(rhs),
          BinOp::Div => lhs.checked_div(rhs).unwrap_or(0),
        }
      }
      Expr::Literal(num) => *num,
    }
  }
}
```

The author also defines a program generator for the language here for benchmarking purposes: https://github.com/sampsyo/flatcalc/blob/c5bbe7bd79f98a3b857f0432d4739a3f4f6241bd/src/main.rs#L118-L136

## The Flattening Idea

Two pieces:

1. Pack all `Expr` objects into a single, contiguous array (the **arena**) instead of heap-allocating them individually.
2. Replace pointers (`Box<Expr>`) with array indices (`u32`) into that arena.

Define the arena type and an index newtype:

```rust
struct ExprPool(Vec<Expr>);
struct ExprRef(u32);
```

The only change to the AST definition:

```rust
 enum Expr {
-    Binary(BinOp, Box<Expr>, Box<Expr>),
+    Binary(BinOp, ExprRef, ExprRef),
     Literal(i64),
 }
```

`ExprPool` gets two trivial methods: `add` (allocate — push to the vec, return index) and `get` (dereference — index into the vec).

All existing code just needs mechanical changes:

- Functions become methods on `ExprPool` instead of `Expr`.
- Constructing an `Expr` wraps in `self.add()` to get an `ExprRef`.
- Pattern matching wraps in `self.get()` to go from `ExprRef` to `Expr`.

## Rationale for Flattening?

### Performance

1. **Locality**. Contiguous memory layout means better spatial locality, cache lines and prefetchers work better. A smart allocator *might* achieve similar results, but a dense array removes all uncertainty.
2. **Smaller references**. 32-bit indices vs 64-bit pointers, 50% space savings on all references. Smaller footprint means less bandwidth pressure. Could even use 16- or 8-bit for small structures.
3. **Cheap allocation**. No `malloc` per node, just bump a tail pointer. Hard to beat bump allocation on simplicity.
4. **Cheap deallocation**. ASTs tend to "die together". Instead of traversing all pointers to free each node, free the entire `ExprPool` at once.

::: note
Many intros to arena allocation focus on cheap deallocation (#4) as the main reason. But in compilers, ASTs often persist until the end of compilation, so you might not need to free them at all - making #4 arguably the *least* important benefit in a compiler setting.
:::

### Ergonomics

1. **Easier lifetimes**: One lifetime for the whole AST instead of *n*. In Rust, passing around a `u32` is far less fiddly than managing lifetimes for `&Expr` references.
2. **Convenient deduplication**: Flat arrays make hash consing easy, e.g., reserve the first 128 slots for common integer literals, so `Literal(42)` is just `ExprRef(42)` with no allocation.

::: note
This is similar to salsa's `QueryStorage` ingredient store: Data are stored in an array and ids are returned back as handle to the array. However, that approach is mostly applied to later stages other than parsing.

`rust-analyzer` has a red-green tree approach with DST types. In that approach, nodes are deduplicated in a thread-local cache, but still malloc-ed in a single allocation using the DST optimization. The allocation returns a ref-counted pointer which can be stored in other nodes. -> Essentially, can be combined with this flattening approach?
:::

## Performance Results

Microbenchmark: ~100M AST nodes, generate + interpret (no parser/printer involved).

- **Normal**: 3.1s
- **Flattened**: 1.3s, **2.4x speedup**

Isolating deallocation cost:

- Normal interpreter spent **~38%** of its time just freeing memory.
- Flattened interpreter: deallocation cost is negligible (free the whole vec at once).
- Even comparing "no-free" versions: flattened is still **1.5x faster**. Locality and cheap allocation alone have measurable effects.

## Bonus: Exploiting the Flat Representation

Key insight:

- Because `Expr`s are immutable and built bottom-up, children always appear *before* their parents in the `ExprPool`.
- Reference arrows always go backward in the array, data flows forward.

An "extra-flat" interpreter exploits this: instead of recursive tree-walking, scan the `ExprPool` left-to-right. A dense `state: Vec<i64>` holds one result per node. Binary expressions look up their children's results directly in `state` by index. No recursion needed.

```rust
fn flat_interp(self, root: ExprRef) -> i64 {
    let mut state: Vec<i64> = vec![0; self.0.len()];
    for (i, expr) in self.0.into_iter().enumerate() {
        let res = match expr {
            Expr::Binary(op, lhs, rhs) => {
                let lhs = state[lhs.0 as usize];
                let rhs = state[rhs.0 as usize];
                match op {
                    BinOp::Add => lhs.wrapping_add(rhs),
                    BinOp::Sub => lhs.wrapping_sub(rhs),
                    BinOp::Mul => lhs.wrapping_mul(rhs),
                    BinOp::Div => lhs.checked_div(rhs).unwrap_or(0),
                }
            }
            Expr::Literal(num) => num,
        };
        state[i] = res;
    }
    state[root.0 as usize]
}
```

Performance: 1.2s vs 1.3s for recursive flat interpreter. 8.2% improvement, marginal compared to the flat-vs-pointer gap, but free.

::: note
Bob Nystrom (Crafting Interpreters author)'s observation: this essentially reinvents a **bytecode interpreter**.

- The `Expr` structs are bytecode instructions.
- `u32` indices are variable references.

Swap the state table for a stack and it's indistinguishable from a bytecode interpreter designed from first principles.

"Merely" changing the AST data structure led directly from tree-walking to bytecode!!!
:::

## Further Reading

Compilers:

- **LuaJIT**: Mike Pall attributes performance to its "linear, pointer-free IR."
- **Sorbet** (Ruby type-checker): uses packed arrays, 32-bit indices instead of 64-bit pointers.
- **Oil shell**: large collection of links on "compact AST representation."

Beyond compilers:

- **Gibbon** (Purdue/Indiana): compiles programs to operate directly on serialized/flattened data.
- **Data-oriented design**: Andrew Kelley (Zig) argues for indices in place of pointers.
- **Game dev**: handles vs. pointers, entity-component systems (ECS), all share the same locality themes.
- **Inanna Malick**: same technique on a calculator language in Rust, combined with recursion schemes from Haskell.

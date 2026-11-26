---
_type: Blog
_label: 'Practical DOD: Zig Compiler AST Representation'
url: 'https://podcast.josherich.me/podcast/andrew-kelley-practical-data-oriented-design-dod'
journey: null
site: fref("/01-programming-language-theory/blogsites/andrew-kelley.td")
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/arena-allocator.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'talk'
---

Talk by Andrew Kelley (Zig creator) at Handmade Seattle 2021 on practical data-oriented design (DoD) and how he applied it across the Zig self-hosted compiler pipeline.

![video](https://vimeo.com/649009599)

::: note Core Premise
**The CPU is fast, main memory is slow.**

1. **Memory hierarchy**: Each step down from L1 -> L2 -> L3 -> main RAM is roughly an **order of magnitude slower**. Every memory access goes through a **64-byte cache line**, so the entire game is avoiding cache line evictions (cache misses).
2. **Math is faster than memory**: Even integer multiplication is faster than an L1 cache read. **Stop memoizing what you can cheaply recalculate.**
3. **The DoD recipe**: Find the struct you have the most of in memory, and make each instance smaller without losing information.
:::

## Part 1: Struct Layout, Alignment, and Padding

Every type has a **natural alignment** and a **size**. Structs align to their largest field, and the compiler inserts padding bytes both between fields and at the tail so the total size is a multiple of the struct's alignment.

```
// 1. Field order matters:
struct { a: u32, b: u64, c: u32 }  // align 8, size 24 (4B pad after a, 4B pad after c)
struct { a: u32, c: u32, b: u64 }  // align 8, size 16 (0B padding!)

// 2. The 1-bit boolean trap:
struct { a: u32, c: u32, b: u64, flag: bool } // align 8, size 24!
```

> In information theory, a `bool` is **1 bit** of information. Adding it to an 8-byte-aligned struct costs **8 bytes (64 bits)**, which is 63 bits of pure padding waste.

## Part 2: Five Strategies to Shrink Memory Footprint

### Strategy #1: Indices Instead of Pointers

**Problem**: on a 64-bit CPU, every pointer takes 8 bytes and forces 8-byte alignment. Even though 64-bit machines can address more RAM, pointer-heavy programs use up to 2x more RAM by default.

**Observation**:

- Most objects of the same type live in a bounded collection or arena rather than arbitrary addresses across the 64-bit virtual address space.

**Idea**:

- Store objects in a flat array/arena instead of heap-allocating them individually.
- Replace `*T` (8 bytes, align 8) with a `u32` index (4 bytes, align 4). -> Same core idea as ${fref("./flattening-asts.td")}.

**Nuances**:

- **Double win**: halves reference size *and* drops alignment from 8 to 4, avoiding 4-byte padding when mixing references with `u32` fields.
- **Type safety caveat**: raw `u32` indices lose compile-time type checking (you could accidentally pass an index into array A where array B was expected). Use distinct integer/enum types (`enum(u32) { _ }`) or typed handles (see Andre Weissflog's *[Handles are the better pointers](https://floooh.github.io/2018/06/17/handles-vs-pointers.html)*).

### Strategy #2: Store Booleans Out-of-Band

**Problem**: adding `alive: bool` to a `Monster` struct forces 7 bytes of alignment padding, bloating the struct from 16 bytes to 24 bytes. We can't just delete the field because we still need to know if a monster is alive.

**Observation**:

- In information theory, a boolean is 1 bit of state. It does not need to be stored as a field inside the struct if it can be encoded by the container that holds the struct.

**Idea**: move that 1 bit of state out of the struct and encode it by **where** the item lives (or in a separate bitset).

- Split a single `monsters` array into two arrays: `alive_monsters` and `dead_monsters`.
- Combined with Strategy #1 (replacing `*Animation` with `AnimIndex`), `Monster` drops from **24 bytes to 12 bytes**.

```zig
// Before: 24 bytes per monster (with 7 bytes padding)
const Monster = struct {
  anim: *Animation,
  x: u32,
  y: u32,
  alive: bool,
};

// After: 12 bytes per monster (index + out-of-band bool)
const Monster = struct {
  anim: AnimIndex,
  x: u32,
  y: u32,
};
var alive_monsters: ArrayList(Monster) = ...;
var dead_monsters: ArrayList(Monster) = ...;
```

> According to information theory, the boolean is still there: it is which array the monster is in. According to memory footprint, it is completely gone.

**Additional benefit**:

- A game loop that previously loaded `monster.alive` and branched (`if (!monster.alive) continue;`) now just loops over `alive_monsters`.
- No memory load for dead monsters, no branch in the loop, fewer cache misses.

### Strategy #3: Eliminate Padding with Struct of Arrays (`MultiArrayList`)

**Problem**: when a struct mixes fields of different alignments (e.g., an 8-byte pointer and a 1-byte enum tag), an **Array of Structs (AoS)** inserts 7 bytes of padding on *every single element* so the next element starts at an 8-byte boundary. For 10,000 monsters, that is **160 KB**.

**Observation**:

- Padding only exists because fields of different alignments are interleaved in the same contiguous array. Homogeneous arrays never need inter-element padding.

**Idea**: store each field in its own separate contiguous array (**Struct of Arrays / SoA**).

- An array of 8-byte pointers needs 0 padding between elements.
- An array of 1-byte enum tags has 1-byte alignment, so it also needs 0 padding between elements.

```
Array of Structs (AoS): 16 bytes/elem -> 160 KB for 10,000 monsters
[ ptr (8B) | tag (1B) | pad (7B) ][ ptr (8B) | tag (1B) | pad (7B) ] ...

Struct of Arrays (SoA): 9 bytes/elem  -> 91 KB for 10,000 monsters
ptrs: [ ptr (8B) ][ ptr (8B) ][ ptr (8B) ] ...   (align 8, 0 padding)
tags: [ tag (1B) ][ tag (1B) ][ tag (1B) ] ...   (align 1, 0 padding)
```

In Zig, switching `std.ArrayList(Monster)` to `std.MultiArrayList(Monster)` is a one-line change with the same API, dropping 10,000 monsters from **160 KB to 91 KB**.

### Strategy #4: Store Sparse Data in Hash Maps

**Problem**: suppose each `Monster` can hold up to 4 items (`items: [4]Item`). Storing that array inline inside every `Monster` takes **366 KB** for 10,000 monsters (including array capacity overhead).

**Observation**:

- In actual gameplay, 90% of monsters are not holding anything (`items` is all zeros).
- Every monster is paying the memory cost for a worst-case field that only 10% of them use.

**Idea**: pull `items` out of the `Monster` struct and store it out-of-band in a hash map keyed by `monster_index: u32`.

- Even including hash map overhead, memory for 10,000 monsters (with 10% holding items) drops from **366 KB to 198 KB**.

> Design data structures around the **observed distribution** of your data, not the worst-case union of all fields.

### Strategy #5: The Encoding Approach

**Problem**: we want to represent polymorphic data in a flat array, such as a `Monster` that can be either a `Human` (20 bytes: hat, shoes, shirt, pants, `has_braces: bool`) or a `Bee` (1 byte: `color` enum), plus common `x, y` coordinates.

- **Naive approach #1 (Tagged Union `union(enum)`)**: **32 bytes** per monster. Every element takes the size of the largest variant, so every 1-byte `Bee` pays for the 20-byte `Human` payload.
- **Naive approach #2 (OOP / Polymorphism)**: **24 bytes** average. Base struct (`tag, x, y`) + subtype specialization for `Bee` vs. `Human`. Better, but still rigid.

**Observation**:

- Low-cardinality fields (like `Bee.color` with 3 values, or `Human.has_braces` with 2 values) only carry a couple bits of information, yet take up whole fields and padding in the payload.
- Not all instances of the same variant need the full payload (e.g., a naked human doesn't need `hat, shoes, shirt, pants`).

**Idea**: give every element a **1-byte `Tag`** and a **fixed-size `common` struct** (stored as SoA via `MultiArrayList`), and use **multiple tag encodings** for the same logical entity:

1. **Fold small fields into the tag**: `Bee.color` and `Human.has_braces` disappear from the payload and become variants on `Tag`.
2. **Spill large payloads to a side array**: `common` has an `extra_index: u32` field whose meaning depends on `Tag`. Naked humans don't use it (costing only **13 bytes** total); clothed humans use `extra_index` to point into a separate `clothes` array.

```zig
const Monster = struct {
  tag: Tag, // stored as SoA via MultiArrayList -> 1 byte, no padding
  common: struct {
    x: u32,
    y: u32,
    extra_index: u32, // repurposed depending on tag!
  },

  const Tag = enum(u8) {
    bee_yellow,            // bee color folded directly into the tag!
    bee_black,
    bee_red,
    human_naked,           // no extra data needed -> 13 bytes total
    human_naked_braces,    // has_braces bool folded into the tag!
    human_clothed,         // extra_index points into clothes_array
    human_clothed_braces,
  };
};
```

Assuming a 50/50 split of humans and bees and a 50/50 split of clothed and naked humans, average size drops from **32 bytes to ~17 bytes** per monster.

## Part 3: Case Study - The Zig Self-Hosted Compiler

The Zig compiler pipeline transforms data through discrete representations:

```
Source Code --> Tokens --> AST --> ZIR (Untyped IR) --> AIR (Analyzed IR) --> Machine Code
|<-------------- Per-file (embarrassingly parallel) -------------->|<-- Per-function -->|
```

**Observation**:

- We cannot control the format of **Source Code** (fixed by the language spec) or **Machine Code** (fixed by the hardware).
- Everything in between (`Tokens`, `AST`, `ZIR`, `AIR`) is purely internal compiler data layout, so we can apply all five DoD strategies to it.

### Stage 1: Tokens (`64 bytes` -> `5 bytes`)

**Problem**: in the old compiler, each `Token` was a **64-byte** tagged union storing `id`, `start: usize`, `end: usize`, `line: usize`, `column: usize`, and pre-parsed literal values (integers, strings). Every identifier, `+`, and `*` in a file paid 64 bytes.

**Observation**:

1. **`line` and `column` are almost never read**: they are only needed when printing a compile error, and can be calculated lazily by scanning from the start of the source buffer.
2. **Source files don't exceed 4 GiB**: 64-bit `usize` offsets are overkill; `u32` byte offsets are plenty.
3. **`end` offset is redundant**: for keywords and punctuation (like `and` or `*`), the length is already known from the token tag. For identifiers/literals, if a later pass ever needs the end offset, we can just re-tokenize from `start`.
4. **Eager literal parsing bloats every token**: integer and string literals can be parsed on demand in later passes for the same CPU cost without storing them in `Token`. -> Same lazy decoding principle as ${fref("./data-oriented-design-in-yukus-parser.td")}.

**Zig's Solution**: strip `Token` down to just what it is (`tag`) and where it starts (`start`), stored in a `MultiArrayList(Token)` with zero padding:

```zig
pub const Token = struct {
  tag: Tag,          // 1 byte
  start: ByteOffset, // u32 (4 bytes)
};
// Stored in a MultiArrayList(Token) -> 5 bytes per token, zero padding!
```

### Stage 2: AST Nodes (`120 bytes` -> `~15.6 bytes` avg)

**Problem**: in the old compiler, each AST node was a **120-byte** tagged union containing booleans, line/column numbers, multiple token links, and worst-case inline fields.

**Observation**:

1. **One token per node is enough**: because the AST is a tree, a node only needs to store its primary token (`main_token`, e.g., `+` in `a + b`, or `fn` in a function declaration). Full source spans can be derived by walking the subtree's min/max tokens when needed.
2. **Most nodes have at most two children**: binary expressions, unary expressions, and simple statements only need two `u32` indices (`lhs` and `rhs`). Only complex nodes (like function declarations or blocks) need more.
3. **The same syntax construct has common simple forms and rare complex forms**: a variable declaration or an `if` statement often omits optional parts (like alignment, section, or `else` branches).

**Zig's Solution**: apply the **Encoding Approach** using a `MultiArrayList(Node)` for fixed-size columns (`1B tag + 4B main_token + 8B data = 13 bytes` base) plus a flat `extra_data: []u32` array for variable-length payloads:

```zig
pub const Ast = struct {
  source: [:0]const u8,
  tokens: TokenList.Slice,
  nodes: NodeList.Slice,    // MultiArrayList(Node)
  extra_data: []Node.Index, // variable-length payloads ([]u32)
};

pub const Node = struct {
  tag: Tag,               // 1 byte: enum(u8)
  main_token: TokenIndex, // 4 bytes: u32 index into tokens (e.g. `fn`, `+`, `if`)
  data: Data,             // 8 bytes: two u32 slots (lhs, rhs)

  pub const Data = struct {
    lhs: Index, // u32
    rhs: Index, // u32
  };
};
```

How `Node.Tag` uses multiple encodings:

- When a node fits in two `u32` slots, `lhs` and `rhs` hold child node indices directly.
- When a node needs more than two slots, `lhs` and/or `rhs` hold an index (or `{start, end}` range) into `extra_data`.
- Instead of one canonical tag per construct, `Node.Tag` defines specialized encodings matched to common shapes:

  - Variable declarations have **3 encodings** (e.g., simple vs. local vs. full global var decl).
  - `if` expressions have **2 encodings** (`if_simple` fits entirely in `lhs`/`rhs`; full `if` spills into `extra_data`).
  - `while` loops have **2 encodings**.

**Results (`Tokens` + `AST` refactor on Zig stdlib)**:

- Average AST node size dropped from **120 bytes to 15.6 bytes** (13 bytes base + ~2.6 bytes average in `extra_data`).
- **22% reduction** in wall-clock parsing time.

::: note Comparison with Yuku
This is the "denser" approach referenced at the end of ${fref("./data-oriented-design-in-yukus-parser.td")}. The Zig compiler can get away with `tag + main_token + two u32 words` (and multiple specialized tags per construct) because the compiler is the primary consumer. Yuku keeps one tag per AST kind with named, typed fields so it can auto-generate a JS decoder for external tools.
:::

### Stage 3: ZIR - Untyped Zig IR (`54.0 bytes` -> `~20.3 bytes` avg)

ZIR takes the AST and lowers it into an untyped intermediate representation before semantic/type analysis (`Sema` / `AIR`).

**Problem**: the old IR used an OOP/polymorphic layout where each instruction was a variable-sized heap object linked by 64-bit pointers, averaging **54.0 bytes** per instruction. Every instruction carried a full canonical source location, and even simple constants like `true` or `false` required allocating a full instruction.

**Observation**:

1. **Not every instruction needs a source location**: many can be inferred from surrounding context, and when a location is needed, a `u32` index into `tokens` or `nodes` is half the size of a full location struct.
2. **Instruction references are pointers**: replacing 64-bit instruction pointers with `u32` indices halves reference overhead.
3. **Simple constants don't need instructions**: allocating an IR instruction just to represent `true`, `false`, `0`, or `void` wastes both memory and cache lines.

**Zig's Solution**: apply the **Encoding Approach** to ZIR instructions (`tags`, `data`, `extra`, `string_table`):

- **Encoding defines source location meaning**: the instruction `Tag` tells you whether the location `u32` is a `TokenIndex`, a `Node.Index`, or omitted.
- **Boolean flags folded into `Tag`**: e.g., `strong` vs. `weak` linkage becomes distinct instruction tag variants.
- **Inline immediates in `Ref`**: an instruction reference (`Ref`) is a `u32` enum whose low values are reserved for common constants (`true`, `false`, `null`, `void`, `0`, `1`, primitive types), while higher values index into the instruction array. Referencing `true` allocates **zero** instructions! -> Same reserved-slot deduplication idea as ${fref("./flattening-asts.td")}.

**Results (`ZIR` refactor)**:

- Average ZIR instruction size dropped from **54.0 bytes to 20.3 bytes**.
- **39% reduction** in wall-clock ZIR generation time (on top of the 22% parsing speedup).

### Bonus: Parallelism & Disk Caching via Flat Arrays

**Observation**:

- Every stage up to ZIR (`Source -> Tokens -> AST -> ZIR`) is purely per-file: the same source file always produces the exact same ZIR, regardless of compiler flags or target architecture.
- A ZIR module in memory is now just **4 flat arrays** (`tags`, `data`, `extra`, `string_table`) with zero pointers.

**Zig's Solution**:

1. **Embarrassingly parallel front-end**: distribute per-file parsing and ZIR generation across a thread pool, reaching **8.9 million lines of code per second** on a laptop.
2. **One-syscall disk caching**: because the 4 arrays contain no pointers, save and load ZIR from the filesystem cache using a **single POSIX `writev` / `readv` syscall** by passing the 4 array slices directly to the OS kernel.

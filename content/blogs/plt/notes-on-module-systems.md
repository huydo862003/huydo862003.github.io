---
createdAt: "2026-03-28"
updatedAt: 2026-04-12
title: "Notes on module systems"
url: "Notes on module systems"
author: ""
journey: plt
site: alexey-kladov-matklad
latestPost: ""
lastChecked: ""
posts: []
tags: ["PLT", "blog"]
---

Same context as On the Criteria To Be Used in Decomposing Systems into Modules.

# First phase

- Title: Notes on module system.

    → Not much to say, but it conveys a highly personal take.
    
- Summary: What a better Module system for Rust would look like…
- Introduction:
    - Rust's module system is its second most exciting feature after the Borrow checker.

        → Why?
        
    - Reasons why the decentralized ecosystems of libraries like [crates.io](http://crates.io/) robust:
        - Explicit separation between crates and modules.
            - Crate is the physical Compilation unit (a library or an executable). Rust requires that crate dependencies form a [Directed acyclic graph (DAG)](/journeys/plt/concepts/directed-acyclic-graph-dag).
            - Unlike crates, modules are allowed to have **circular dependencies**.
        - No single global namespace, unlike, say C++.
            - In many languages, a library has a global name (e.g., in C++, there is only one `std`). If two libraries use the same name, they collide.
            - A crate in Rust doesn't know its own name - it's cargo who names it and this can be changed:

                ```toml
                extern_log = { package = "log", version = "1.0" }.
                ```

        → Because names are localized to the "edges" between crates, `crates.io` doesn't need a central authority to ensure that crate A and crate B don't use the same internal names.

        **Rust allows linking-in several versions of the same crate without the fear of naming conflicts (via Mangling).**
        
    - However, the author felt that the Concrete/Surface syntax used to express the model of the module system is suboptimal.

        In a pre-2018 survey, the Rust Module system is the most confusing aspect after Lifetime.

        Post-2018 was better (why?), but still some regular questions about module system.
        
- Conclusion: Nothing… just a disclaimer that these are not to be taken as the absolute truth.

The 5Cs:

- Category:
    - Module system.
- Context:
    - The Rust module system is awesome, offering a way to maintain & manage robust & flexible ecosystem of crates, without some common problems, say namespace pollution, etc.
    - However, it's still very confusing.

    → The Rust module system can be better.
    
- Contributions:
    - Some skin-in-the-game opinions about better ways to structure a module system.
- Correctness:
    - There are references to surveys (although, understandably, there are no links to those surveys).
    - These are some personal thoughts of the author.
- Clarity:
    - Quite clear, except that sometimes I had to make some leaps to understand what he's trying to convey: Introduction:

# Second phase

- Introduction (again!)
    - Rust module system allows for a robust ecosystem of crates:
        - Separation between Rust crates (physical units of compilation) and Rust modules (logical organization that doesn't really affect compilation).
        - No single global namespace for crates.

            → Rust allows linking several versions of the same crate without naming conflicts.

→ Quite insightful from the part of the author, however, it can require a bit of context.

- Limitations of the state of affairs:
    - Module system is confusing (just after Lifetime, in a pre-2018 survey).
    - Somehow, after 2018, the situation was improved.

- First point: Be more precise about Visibility.
    - The most important question about a Rust item: Can it be visible outside of the Compilation unit?

        → 2 answers leading to 2 assumptions:
        
        - Closed world (every usage of the item is known).
        - Open world (usages of the item are not knowable).
        
        > Remarks: Interesting. These are my speculations:
        > 
        > - Closed world may allow for aggressive optimization and flexibility, but I think it causes a lot of compilation overhead, as this requires informing a crate of external crates when we're compiling external crates, so the used crates cannot be compiled first.
        > - Open world offers the opposite.

        **→ This should be reflected in the module system.**
        
        - `pub` → Visible inside the whole Compilation unit, but not further (I thought this is visible to the whole world?)
        - `export` (I don't recall Rust has this) or `pub*` → Visible to the whole world.
        
        > Remarks: Things are a bit confusing here, a link to elaborate will be appreciated.
        > 
        > 
        > → Hmm, it seems like this is only the author's desired state?
        > 
    - These can be achieved in today's Rust with `pub(crate)`, `-Dunreachable_pub` + some tolerance for compiler's false positive.

        However, other parts of the Rust's module system, such as `pub(in some::path)` do not really hold their weights.
        
        > Making visibilities more precise within a single CU doesn't meaningfully make the code better, as you can control and rewrite all the code anyway.
        > 

        Remarks:
        
        - Hmm, I don't really think so… I mean `pub(in some::path)` really does seem clunky, but if visibility is done right, it does help set clear-cut boundary of responsibility between modules in a crate.
        - HOWEVER, he can be correct regarding the phrasing of "more precise".
    - Proposed:
        - `fn foo()` is visible in the current module only (not its children).
        - `pub fn foo()` is visible anywhere inside the current crate.
        - `pub* fn foo()` is visible to other crates using ours.
    - `use` being an item is an unnecessary cuteness (`a::b` can use items imported in `a`, a.k.a a child module can access items imported in the parent module).
        
        > Imports should only introduce the name into module's namespace, and should be separate from intentional re-exports.
        > 

        Remarks: I think this is regarding **explicitness**.
        
    - CONSIDER (not 100% sure) banning glob re-exports.

        This might be related to the rust-analyzer's 3 architecture for IDE blog posts, where it thinks this aspect of Zig is cool as it helps with local reasoning of toolings.
        
        > Though, as Rust has namespaces, looking at `pub use submod::thing` doesn't tell you whether the thing is a type or a value, so this might not be a meaningful property after all.
        > 

        → So having namespaces (like one for types and one for values) defeats the purpose of banning glob re-exports… The import should be explicitly spelling out if an imported item is a type or a value.
        
- Second point: Improve module tree/directory structure mapping.

    Some existing problems relating to visibility:
    
    - Confusion between binary and library crates.
        
        > It's common for new users to have `mod foo;` in both `src/main.rs` and `src/lib.rs`.
        > 
    - `mod {}` is a bit confusing:
        
        > It's common (even for some production code I've seen) to have `mod foo { stuff }`*inside* `foo.rs`.
        > 
    - Duplicate inclusion (not sure what it means…), maybe each test file is a module:
        
        > It's common to start every file in `tests/` with `mod common;`. Rust book even recommends some awful work-around to put common into `common/mod.rs`, just so it itself isn't treated as a test.
        > 
    - Inconsistency:
        
        > Large projects which don't have super-strict code style process end up using both the older `foo/mod.rs` and the newer `foo.rs, foo/*` conventions.
        > 

        Remarks: I don't think is much of a problem though…
        
    - Forgotten files:
        
        > It is again pretty common to have some file somewhere in `src/` which isn't actually linked into the module tree at all by mistake.
        > 
- Less-objective issues
    
    > 
    > 
    > - `mod.rs`less system is self-inconsistent. `lib.rs` and `main.rs` *still* behave like `mod.rs`, in a sense that nested modules are their direct siblings, and not in the `lib` directory.
    > - Naming for crates roots (`lib.rs` and `main.rs`) is ad-hoc.
    > - Current system doesn't work well for tools, which have to iteratively discover the module tree. You can't process all of the crate's files in parallel, because you don't know what those files are until you process them.

    Remarks: The third point is again, related to Zig.

- A better system
    1. A compilation unit = A directory with Rust source files.
    2. Relative file paths = module paths.
    3. No `mod foo;` nor `mod foo {}`.

        Can be useful, but doesn't mean it should be part of the language.
        
    4. Use `mod.rs` but name it `_<name-of-the-module>.rs` instead.

        Why:
        
        - Sort it first alphabetically.
        - Generate a unique fuzzy findable name.

        Remarks: Mainly for productivity.
        
        - Example

            ```markdown
            /home/matklad/projects/regex
              Cargo.toml
              src/
                _regex.rs
                parsing/
                  _parsing.rs
                  ast.rs
                rt/
                 _rt.rs
                 dfa.rs
                 nfa.rs
              bins/
                grep/
                  _grep.rs
                  cli.rs
              tests/
                _tests.rs   # just a single integration tests binary by default!
                lookahead.rs
                fuzz.rs
                     
            ```

            ```markdown
            
            crate::{
                parsing::{ast}
                rt::{nfa, dfa}
            }
            ```
            
    - Example of conditional compilation

        To do conditional compilation, you'd do:

        ```markdown
        mutex/
          _mutex.rs
          linux_mutex.rs
          windows_mutex.rs
        ```

        where `_mutex.rs` is

        ```markdown
        #[cfg(linux)]
        use linux_mutex as os_mutex;
        #[cfg(windows)]
        use windows_mutex as os_mutex;
        
        pub struct Mutex {
           inner: os_mutex::Mutex
        }
        ```
        
        > But of course we shouldn't implement conditional compilation by barbarically cutting the AST, and instead should push conditional compilation to after the type checking, so that you at least can check, on Linux, that the windows version of your code wouldn't fail due to some stupid typos in the name of `#[cfg(windows)]` functions. Alas, I don't know how to design such conditional compilation system.
        > 
    
    > I think this approach would make most of the pitfalls impossible. E.g, it wouldn't be possible to mix several different crates in one source tree. Additionally, it'd be a great help for IDEs, as each file can be processed independently, and it would be clear just from the file contents and path where in the crate namespace the items are mounted, unlocking
    [map-reduce style IDE](https://rust-analyzer.github.io/blog/2020/07/20/three-architectures-for-responsive-ide.html).
    > 
    - Drop nested `use` group as it causes inconsistencies.
    - Make `use` paths consistent with other paths:
        - Paths in `use` and paths in regular code historically resolved differently, requiring different syntax for the same thing.
        - The 2018 edition improved this but didn't fully eliminate the inconsistency.

        ```rust
        // Regular code - works fine
        let map = std::collections::HashMap::new();
        
        // Pre-2018: `use` required a leading `::` to mean the same path
        use ::std::collections::HashMap;
        
        // Post-2018: leading `::` no longer required, but edge cases remain
        // e.g. a local module named `std` would shadow the crate in one context but not the other
        use std::collections::HashMap;
        ```

# Third phase

# Summary

- Summary from Claude Opus 4.6
    
    ## Summary: Notes on a Better Module System for Rust-like Languages
    
    ### Context

    An informal, unedited reflection (confidence ~0.5) on improving Rust's module system, written Nov 27, 2021.
    
    ---
    
    ### What Rust Gets Right
    
    - Clear separation between **crates** (DAG) and **modules** (can be mutually dependent)
    - No global namespace - crate names live on dependency edges, not on crates themselves
    - Multiple versions of the same crate can coexist without naming conflicts
    
    ---
    
    ### Problem 1: Visibility System

    **Current issues:** `pub` is ambiguous about whether something is crate-internal or externally exported.

    **Proposed fix - three explicit tiers:**
    
    - No modifier → visible in current module only
    - `pub` → visible anywhere within the crate
    - `pub*` / `export` → visible to external crates

    **Other suggestions:**
    
    - `pub(in some::path)` doesn't pull its weight - too complex for too little benefit
    - `use` should only introduce names locally; re-exports should be explicit and separate
    - Consider banning glob re-exports so all names in a module are spelled out explicitly
    
    ---
    
    ### Problem 2: Module Tree / Directory Structure

    **Common pitfalls today:**
    
    - `mod foo;` accidentally placed in both `main.rs` and `lib.rs`
    - Inline `mod foo { }` blocks inside `foo.rs`
    - Every file in `tests/` redundantly repeating `mod common;`
    - Large projects inconsistently mixing `foo/mod.rs` and `foo.rs` + `foo/*` conventions
    - Source files accidentally left unlinked from the module tree
    - Tooling can't process crate files in parallel since the tree must be discovered incrementally

    **Proposed fix - directory = compilation unit:**
    
    - File paths map directly to module paths; no `mod foo;` or `mod foo {}` declarations needed
    - Replace `mod.rs` with `_modulename.rs` (sorts first alphabetically, uniquely fuzzy-findable)
    - `lib.rs` / `main.rs` replaced by a consistent naming convention

    **Example structure:**

    ```
    src/
      _regex.rs         ← crate root
      parsing/
        _parsing.rs
        ast.rs
      rt/
        _rt.rs
        dfa.rs
        nfa.rs
    ```
    
    ---
    
    ### Problem 3: Conditional Compilation
    
    - Proposed: use `use`-based re-exports with `#[cfg(...)]` per file rather than cutting the AST
    - Ideal (unresolved): push conditional compilation to *after* type-checking, so cross-platform code can be validated on any platform - but no concrete solution offered
    
    ### Other Minor Points
    
    - `use` should follow identical path resolution rules to the rest of the language - no implicit `::` special cases
    - Nested `use` groups (e.g. `use collections::{ hash::{...}, ... }`) lead to inconsistent style and should be removed

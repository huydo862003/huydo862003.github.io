---
published: true
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Making sense of TypeScript using set theory
url: Making sense of TypeScript using set theory
author: ""
journey: plt
site: ""
latestPost: ""
lastChecked: ""
posts: []
tags: []
---
# First pass

- The author felt he's proficient enough with Typescript.
- However, he was ashamed that he didn't quite get some Typescript's behaviors.
    
    Example:
    
    > However, to my despair, some low-level behaviors still confuse me:
    > 
    > - Why does `0 | 1 extends 0 ? true : false` evaluate to `false`?
    > - I'm very ashamed, but I sometimes confuse "subtype" and "supertype". Which is which?
    > - While we're at it, what are type "narrowing" and "widening", and how do they relate to sub/supertypes?
    > - If you want an object that satisfies both `{ name: string }` and `{ age: number }`, do you `&` or `|`? Both make some sense, since I want a *union* of the functionality in both interfaces, but I also want the object to satisfy left & (and) right interfaces.
    > - How is `any` different from `unknown`? All I get is imprecise mnemonics like "Avoid Any, Use Unknown". Why?
    > - What, exactly, is `never`? "A value that *never* happens" is very dramatic, but not too precise.
    > - Why `whatever | never === whatever` and `whatever & never === never`?
    > - Why on earth is `const x: {} = true;` valid TS code? `true` is clearly not an empty object.
- Before delving, let me make some educated answers to his questions
    1. `0 | 1 extends 0 ? true : false` evaluates to `false` makes sense when we consider assignability: A subtype can be assigned to a supertype, but not vice versa, except if two are the same.
        
        Given that: `const zero: 0 = 0` and `const zoo: 0 | 1 = 1`.
        
        - `const num: 0 = zoo` is definitely invalid.
        - `const num: 0 | 1 = zero` is definitely valid.
        
        -> `typeof zero` is a subtype of `typeof zoo`.
        
    2. This one is obvious to me (at least).
    3. Type narrowing -> An unsafe cast of a supertype into a subtype.
        
        Type widening -> A safe cast of a subtype into a supertype.
        
    4. We would want `&`.
        
        If we use `|`, the resulting type would be an "either having this property or that property".
        
    5. `unknown` is a supertype of all types.
        
        `any` is both a subtype and a supertype of all types.
        
    6. `never` is a subtype of all types.
        
        However, all types can be explicitly narrowed to `never`.
        
    7. A type `|` with `never` - a subtype of all type - is the same as the original type itself.
        
        Similarly, a type `&` with `never` should have essentially the same capability as `never`.
        
    8. I don't know this one for sure.
- Category: Typescript, type system, set theory.
- Context:
    - Refresh knowledge on set theory.
    - Address some of the behaviors of Typescript that may look weird on the surface.
- Contributions: A set-theory perspective on Typescript's type system.
- Correctness: The set-theory perspective for type system is a pretty classic one.
- Clarity: Pretty good.

# Second pass

- Interpretation of types as sets:
    - Universe: All values in Javascript programs.
    - Type: A set of values.
    - Some types can be represented in TS, while other can not - for example, "non-zero numbers".
    - `A extends B`: "A is subset of B".
    - Type union `|`: Set union.
    - Type intersection `&`: Set intersection.
    - `Exclude<A, B>`: Difference operator, except it *only* works when both `A` and `B` are union types.
    - `never`: Empty set.
    
    > This change of view already yields some useful insights:
    > 
    > - Subtype of type A is a *subset* of type A. Supertype is a superset. Easy.
    > - *Widening* makes a type-set wider by allowing some extra values. *Narrowing* removes certain values. Makes geometrical sense.
- Boolean:
    - Typescript treats `boolean` as a finite union of `true | false`.
- String and others:
    - Typescript does not actually as an infinite union.
    - `Exclude<string, 'a'>` would not work.
    - When combining a string *union* with a *template,* TS is smart enough to just filter the literals againts the template, so that `'a' | 'b' & `a${string}` = 'a'`.
    - TS is not *smart enough* to merge templates, so you get really fancy ways of saying `never`, such as ``a${string}` & `b${string}``.
- Objects & Interfaces:
    - `{ ... }`: A value on which you can access some properties.
    - `const x: { toString(): string } = 9;` is valid.
    - `keyof number` gives us `"toString" | "toFixed" | "toExponential" | "toPrecision" | "valueOf" | "toLocaleString"`. \to Typescript assumes numbers are objects, and this mirrors Javascript's autoboxing behavior.
    - `null` and `undefined` do not satisfy `{}`, because they throw if you try to read a property.
    - `object`: non-primitive type.
- `unknown`: The universe of JS values.
    1. `unknown` is *not* a union of all other base types, so you can't `Exclude<unknown, string>`.
    2. `unknown extends string | number | boolean | object | bigint | symbol | null | undefined` is false, meaning that some TS types are not listed.
- `any`: Weird behavior.
    - `any extends string ? 1 : 0` evaluates to `0 | 1` which is basically a "dunno".
    - Even `any extends never ? 1 : 0` evaluates to `0 | 1`, meaning that `any` *might* be empty.
        
        \to `any` is "some set, but we're not sure which one" - like a type `NaN`.
        
    - However, upon further inspection, `string extends any`, `unknown extends any` and even `any extends any` are all true, none of which holds for "some set".
        
        \to So, `any` is a ***paradox*** - every set is a subset of `any`, but `any` *might* be empty.
        
    - `any extends unknown`, so `unknown` is still the universe, and `any` does not allow "alien" values.

# Third pass

---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "A complete guide to TypeScript's never type"
url: "A complete guide to TypeScript's never type"
author: ""
journey: plt
site: ""
latestPost: ""
lastChecked: ""
posts: []
tags: ["PLT", "blog"]
---

# 1. What is `never`?

The `never` type represents an **empty set of values** - a type that can never have any value assigned to it.

```tsx
declare const any: any;
const never: never = any; // [x] Type 'any' is not assignable to type 'never'
```

**Why it exists:** Just as zero represents "nothing" in math, `never` represents **impossibility** in the type system - functions that never return, code paths that should be unreachable, or types that can't exist.

---

## 2. How `never` behaves in Unions & Intersections

### In Unions: `never` disappears

```tsx
type Result = never | string; // string
```

Like adding zero: `0 + 5 = 5`

### In Intersections: `never` absorbs everything

```tsx
type Result = never & string; // never
```

Like multiplying by zero: `0 × 5 = 0`

---

## 3. Use Cases

### 3.1 Exhaustive Switch/If-Else Checking

**Problem:** Ensure all cases of a union are handled.

**Solution:** Create a function that only accepts `never`. If any case is unhandled, TypeScript errors because the remaining type isn't `never`.

```tsx
function assertNever(x: never): never {
  throw new Error("Unexpected value: " + x);
}

type Color = 'red' | 'green' | 'blue';

function getColorName(c: Color): string {
  switch (c) {
    case 'red':
      return 'Red';
    case 'green':
      return 'Green';
    // case 'blue' is missing!
    default:
      return assertNever(c);
      // [x] Argument of type 'string' is not assignable to parameter of type 'never'
  }
}

```

**Why it works:** After handling `'red'` and `'green'`, TypeScript knows `c` can still be `'blue'`. Since `'blue'` isn't `never`, the error alerts you to the missing case.

---

### 3.2 Partially Disabling Structural Typing

**Problem:** You want a function to accept *either* `VariantA` or `VariantB`, but not an object with properties from both.

**Solution:** Mark the "other" property as `never` in each variant.

```tsx
// [x] Without never - allows combined objects
type VariantA = { a: string };
type VariantB = { b: number };

declare function fn(arg: VariantA | VariantB): void;

fn({ a: 'foo', b: 123 }); // No error (but we don't want this!)

```

```tsx
// With never - blocks combined objects
type VariantA = { a: string; b?: never };
type VariantB = { b: number; a?: never };

declare function fn(arg: VariantA | VariantB): void;

fn({ a: 'foo', b: 123 }); // [x] Types of property 'a' are incompatible

```

**Why it works:** An object with both `a` and `b` can't satisfy either variant - `b` can't be both `number` and `never`.

---

### 3.3 Blocking API Methods (Read-Only Pattern)

**Problem:** Create a read-only version of a class that prevents calling certain methods.

**Solution:** Type the method's parameter as `never`.

```tsx
class Cache<T, R> {
  put(val: T): boolean { /* ... */ }
  get(): R { /* ... */ }
}

class ReadOnlyCache<R> extends Cache<never, R> {}

const cache = new ReadOnlyCache<string>();
cache.get();        // Works
cache.put("data");  // [x] Argument of type 'string' is not assignable to type 'never'

```

**Why it works:** Since nothing can be assigned to `never`, `put()` becomes uncallable.

---

### 3.4 Filtering Union Members (Conditional Types)

**Problem:** Extract only certain members from a union type.

**Solution:** Use a conditional type that returns `never` for non-matching members (they get dropped from the union).

```tsx
type Foo = { name: 'foo'; id: number };
type Bar = { name: 'bar'; id: number };
type All = Foo | Bar;

type ExtractByName<T, Name> = T extends { name: Name } ? T : never;

type Result = ExtractByName<All, 'foo'>; // Foo

```

**How it works step-by-step:**

1. Distributes over union: `ExtractByName<Foo, 'foo'> | ExtractByName<Bar, 'foo'>`
2. Evaluates each: `Foo | never`
3. `never` drops out: `Foo`

---

### 3.5 Filtering Object Keys (Mapped Types)

**Problem:** Remove certain properties from an object type based on their value types.

**Solution:** Remap keys to `never` to exclude them.

```tsx
type FilterByValueType<Obj, ValueType> = {
  [Key in keyof Obj as Obj[Key] extends ValueType ? Key : never]: Obj[Key]
};

interface Person {
  name: string;
  age: number;
  active: boolean;
}

type StringPropsOnly = FilterByValueType<Person, string>;
// { name: string }

```

**Why it works:** Keys remapped to `never` are excluded from the resulting type.

---

### 3.6 Control Flow Narrowing

**Problem:** Help TypeScript understand that code after a certain point is unreachable.

**Solution:** Use functions that return `never` (e.g., throwing functions).

```tsx
function throwError(msg: string): never {
  throw new Error(msg);
}

let value: string | undefined;

if (!value) {
  throwError("Value is required");
}

value; // string (undefined is narrowed out)

```

```tsx
// Also works with ?? and ||
const guaranteed = value ?? throwError("Missing!"); // string

```

**Why it works:** TypeScript knows `throwError` never returns, so code after it assumes the `if` condition was false.

---

## 4. Common Gotcha: Unexpected `never` in Errors

**Scenario:** You get "Type X is not assignable to type 'never'" unexpectedly.

```tsx
function f(obj: { a: number; b: string }, key: 'a' | 'b') {
  obj= 1;   // [x] Type 'number' is not assignable to type 'never'
  obj= 'x'; // [x] Type 'string' is not assignable to type 'never'
}

```

**Why it happens:** `obj` could be `number` OR `string` at runtime. To be safe, TypeScript requires the assigned value to be compatible with **both** - i.e., `number & string`, which equals `never`.

**Fix:** Use type assertions or function overloads.

---

## 5. Gotcha: Checking if a Type is `never`

**Naive approach fails:**

```tsx
type IsNever<T> = T extends never ? true : false;

type Test = IsNever<never>; // never (not true!)

```

**Why:** TypeScript distributes conditional types over unions. Since `never` is an empty union, there's nothing to distribute over, so it returns `never`.

**Solution:** Wrap in a tuple to disable distribution:

```tsx
type IsNever<T> = [T] extends [never] ? true : false;

type Test1 = IsNever<never>;  // true 
type Test2 = IsNever<string>; // false 
```

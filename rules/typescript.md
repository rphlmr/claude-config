---
paths:
  - "**/*.{ts,tsx,mts,cts}"
---

# TypeScript

- Write precise types. Don't escape the type system to make code compile, such
  as with `as any`, `as unknown as T`, `@ts-ignore`, or untyped `any`
  parameters; fix the types instead.
- `any` is acceptable where precise typing isn't practical, such as deep
  generic or inheritance-heavy type code.
- Avoid unsafe casts and non-null assertions unless the invariant is
  established.

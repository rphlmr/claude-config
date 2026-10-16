---
paths:
  - "**/*.{ts,tsx,mts,cts}"
---

# TypeScript

## Types

- Write precise types. Don't escape the type system to make code compile, such
  as with `as any`, `as unknown as T`, `@ts-ignore`, or untyped `any`
  parameters; fix the types instead.
- `any` is acceptable where precise typing isn't practical, such as deep
  generic or inheritance-heavy type code.
- Avoid unsafe casts and non-null assertions unless the invariant is
  established.
- Check literals against a type with `satisfies` instead of annotating them,
  so the narrow inferred type survives.
- Derive types from their source instead of restating them: `z.output<typeof
  RuleSchema>`, `ReturnType<typeof createFlowMachine>`, indexed access types.
- Name generic parameters for their role when there is more than one or the
  meaning is not obvious (`TActorIdPrefix`, `Output`), not `T` and `U`.

## Modules

- Use named exports. Use a default export only where a framework or tool
  requires one.
- Import types with `import type`, or an inline `type` specifier in a mixed
  import.
- Group imports: packages first, a blank line, then relative imports. Inside
  each group, put type imports before value imports when the formatter does
  not already sort them.

## Functions

- Declare exported and top-level functions with `function`. Use arrow
  functions for inline callbacks and short object members.
- Take an options object, destructured in the signature, once a function needs
  more than two parameters or any optional one.
- Build services as factories: `createSubscriptionService(dependencies)` takes
  a typed `SubscriptionServiceDependencies` object and returns an object of
  named inner functions. Use classes only for errors and stateful resources.
- Name schemas in PascalCase with a `Schema` suffix (`PaymentContextSchema`),
  and validate untrusted input with `safeParse` before using it.
- Use numeric separators and arithmetic for readable constants (`5_000`,
  `64 * 1024`) and template literals over string concatenation.

## JSDoc

- Write doc comments as JSDoc `/** */` blocks, following the `code-style`
  rule on when to add one.
- Document a parameter as `@param seconds - The number of seconds to cache`
  when its name and type leave its meaning or unit unclear, and `@returns`
  when the result is not obvious from the title. Use `@example` for shapes
  worth showing.
- Use `@deprecated` with the replacement to call instead.

## Tests

- Nest one `describe` per unit under test, and phrase each case as
  `it("should <expected behavior>")`, such as
  `it("should return undefined for invalid ISO string")`.
- Separate arrange, act, and assert with blank lines when a case has more than
  two statements.
- Build test input with `make<Thing>()` helpers that take an options object
  with defaults, so each case states only what it changes.

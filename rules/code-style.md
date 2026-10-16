---
paths:
  - "**/*.{ts,tsx,mts,cts,js,jsx,mjs,cjs}"
  - "**/*.{swift,m,mm,kt,kts,java,dart}"
  - "**/*.{go,rs,py,rb,php,cs,scala}"
  - "**/*.{c,h,cc,cpp,hpp}"
  - "**/*.{sh,bash,zsh}"
---

# Code Style

Write code a person can scan. Apply these rules to new and modified code, even
where the surrounding code differs. The repository's formatter and lint
configuration take precedence. Do not reformat unrelated code.

## Layout

- Wrap at about 120 characters. A call, signature, or array that does not fit
  puts one argument per line, or one logical group per line (a flag and its
  value together).
- Separate top-level declarations with a blank line. Keep tightly related
  constants together as one block.
- Inside a function, separate logical steps with one blank line: setup,
  guards, main work, side effects, return. Do not insert blank lines
  mechanically between every statement.
- Put a blank line before and after every `if`, `for`, `while`, `switch`, and
  `try` block, and before the final `return` unless the function is two
  statements long.
- Always use braces and multiline bodies for control flow.
- Object literals with nested objects or more than a few properties, and error
  payloads, go one property per line.
- Wrap long conditions across lines, one operand per line.

## Control Flow

- Lead with guard clauses that return or throw early; keep the main path
  unindented.
- Return `null` for an expected absence, and throw for a broken invariant.
- Run independent async work concurrently instead of awaiting it in sequence.
- Iterate with `for...of` (or the language's plain loop) when the body has side
  effects; keep `map` and `filter` for pure transformations.
- Do not reassign parameters; derive a new local instead.

## Naming

- Name things for what they are in the domain (`blogFixture`, `wranglerDev`,
  `localState`), never a vague word (`blog`, `worker`, `state`, `data`). Code
  is read by new contributors; every name must explain itself.
- Start functions with a verb that says what they do: `create` for factories,
  `get` for lookups, `resolve` for derivations that may fail to `null`, `to`
  for conversions, `assert` for checks that throw, `is` or `has` for
  predicates.
- Put the unit in the name of a measured value (`timeoutMs`, `maxLogLength`),
  or in an end-of-line comment on a computed one: `cache(60 * 60), // 1 hour`.
- Keep a caught error as the `cause` of the error you throw.

## Errors

- Error messages say what failed and on what, with the received value and
  what was expected, such as `Cannot flatten sparse array at: ${path}` or
  `Expected event type to be 'done', but got '${event.type}'`.
- When a project has a structured error type, use it with its message, a
  stable machine-readable label, and the context needed to debug.
- A message that tells the user how to fix the problem names the exact step,
  such as the missing dependency or config line.

## Comments and Docs

- Comment only non-obvious constraints, invariants, trade-offs, or external
  requirements, such as a runtime quirk or why a workaround exists.
- Keep a comment directly above the code it describes, with a blank line
  before it when it starts a new logical step.
- In a long function made of distinct steps, open each step with a short
  header comment naming it (`Serve public files`, `Add logger middleware`).
- Give every exported function, type, and service method a doc comment unless
  its name and signature already say everything (`getToday`). Give a private
  function one only when its logic is hard to follow from the code.
- A doc comment opens with a short title line (`Create a Hono server`,
  `Cache middleware`), then states edge-case behavior (null, empty, or invalid
  input), usage constraints, and why it exists when that is not obvious. Add
  an example when the input and output shapes help.
- Preserve deliberate formatting and blank-line structure.

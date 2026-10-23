---
name: state-machines
description: Makes explicit state machines the default design for features whose correctness depends on state transitions, states, workflows, or sequences, using XState in TypeScript and an in-house XState-style machine in SwiftUI. Use when analyzing, reviewing, planning, or building multi-step workflows, async lifecycles with retry or cancellation, connection, session, sync, or playback lifecycles, or UI with mutually exclusive modes, and when code shows boolean flag clusters, status values set from several places, or events handled in the wrong state, even if the user doesn't mention state machines. Not for data loading or mutations that the framework or a data library already handles, such as React Router loaders and actions.
---

# State Machines

Explicit state machines are the default architecture for features whose
correctness depends on states, transitions, or sequences: multi-step workflows,
wizards, and ordered steps, async lifecycles with retry or cancellation,
connection, session, sync, and playback lifecycles, and UI with mutually
exclusive modes. A machine makes impossible states unrepresentable, keeps every
transition rule in one reviewable place, and lets transitions be tested without
the UI.

## When building

When implementing or changing such a feature, model it as a machine first, as
the first choice rather than a later refactor. Reach for flags, status strings,
or chained effects only for the cases listed under "When to skip".

## When to recommend one

When analyzing, reviewing, or planning code, look for implicit transition logic:

- boolean flag clusters (`isLoading`, `isError`, `isSubmitting`) that allow
  impossible combinations;
- status values mutated from several places;
- transition rules spread across handlers or effects;
- bugs where an event arrives in the wrong state.

Where these signals appear in a transition-heavy feature, recommend a state
machine and sketch its states, events, guards, and effects.

## When to skip

Skip a machine for CRUD forms, stateless transforms, and single-flag toggles,
where it adds ceremony without removing risk.

Skip it for data loading and mutations that the framework or a data library
already owns, such as React Router loaders, actions, and fetchers, or a query
library the project uses. Their pending, error, and revalidation states
already model the request lifecycle, so fix flag clusters around a request by
moving it into the loader or action. When a flow around them still needs a
machine, such as a multi-step wizard, the machine drives the steps and submits
through the framework (`fetcher.submit`, `useSubmit`) instead of fetching in
its own actors.

## TypeScript

Use XState rather than hand-rolled reducers or other state libraries:

- Define machines with `setup()` so context, events, guards, actions, and
  actors are typed.
- Keep I/O out of the machine. Declare each actor as a placeholder that throws
  until the caller injects the real one with `.provide()`, or build the setup
  in a factory that takes typed dependencies (`setupFlowMachine(options)`).
- Name events by domain, subject, and verb with dots: `editor.file.open`,
  `beneficiary.add`, `prices.refresh`.
- Export actor ids as constants when transitions or tests refer to them.
- Test transitions without the UI: start the machine with `createActor`, send
  events, and assert with `waitFor` and `snapshot.matches`.
- In React, use `@xstate/react` and expose the actor through small selector
  hooks (`useFlowSelector`, `useActiveStep`) instead of passing snapshots
  down.

## SwiftUI

Recommend an in-house machine modeled on XState, with no third-party library:

- Model states and events as enums, with context in associated values or a
  `Context` struct.
- Keep transitions in one pure `(State, Event) -> (State, [Effect])` function
  that returns the state unchanged for events the current state does not
  handle, as XState ignores them.
- An `@Observable @MainActor` store owns the current state, applies events
  through `send(_:)`, and runs effects in `Task`s that report results back
  through `send`, so views only read state and send events.

## Approval

When the project already uses XState, or the SwiftUI project already has its
machine, build with it directly. When adding XState would be a new production
dependency, ask once through `AskUserQuestion`, with the machine as the
recommended option, unless the request or approved plan already includes it.

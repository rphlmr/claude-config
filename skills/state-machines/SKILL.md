---
name: state-machines
description: Makes explicit state machines the default design for features whose correctness depends on state transitions, states, workflows, or sequences, using XState in TypeScript and an in-house XState-style machine in SwiftUI. Use when analyzing, reviewing, planning, or building multi-step workflows, async lifecycles with retry or cancellation, connection, session, sync, or playback lifecycles, or UI with mutually exclusive modes, and when code shows boolean flag clusters, status values set from several places, events handled in the wrong state, or a machine that only mirrors status, even if the user doesn't mention state machines. Not for data loading or mutations that the framework or a data library already handles, such as React Router loaders and actions.
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

When analyzing, reviewing, auditing, or planning code, every unit that moves
through phases on events, messages, callbacks, timers, or async results
counts: a class, a factory closure, a hook or component, a module with
top-level state, or a worker entry. Its size and the absence of a known bug
don't exempt it. These signals show an implicit machine:

- boolean flag clusters (`isLoading`, `isError`, `isSubmitting`) that allow
  impossible combinations;
- a hand-rolled status union, or status values mutated from several places;
- transition rules spread across handlers, effects, or methods that call each
  other;
- hand-built locks and gates, such as promise tails or `withResolvers`
  waiters;
- bugs where an event arrives in the wrong state.

A machine that only mirrors status counts too. When the code decides first
and then sends the machine an event, the machine refuses nothing and the real
transitions stay implicit, so recommend moving the decisions into its guards
and actors.

For each unit, recommend a state machine and sketch its states, events,
guards, and effects. Call a unit fine only when "When to skip" covers it, and
name that reason. When you delegate an audit, give the subagent this bar
instead of a stricter one of your own, such as "only risky code".

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

XState is pre-approved. Build the machine with it directly, and add it as a
dependency where the project doesn't have it yet, new projects included,
instead of asking first or leaving the machine as a sketch in a doc. In
SwiftUI, build the in-house machine directly.

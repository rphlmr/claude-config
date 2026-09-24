---
name: state-machines
description: Recommends explicit state machines for features whose correctness depends on state transitions, using XState in TypeScript and an in-house XState-style machine in SwiftUI. Use when analyzing, reviewing, planning, or building multi-step workflows, async lifecycles with retry or cancellation, connection, session, sync, or playback lifecycles, or UI with mutually exclusive modes, and when code shows boolean flag clusters, status values set from several places, or events handled in the wrong state, even if the user doesn't mention state machines.
---

# State Machines

Explicit state machines are the preferred architecture for features whose
correctness depends on state transitions: multi-step workflows and wizards,
async lifecycles with retry or cancellation, connection, session, sync, and
playback lifecycles, and UI with mutually exclusive modes. A machine makes
impossible states unrepresentable, keeps every transition rule in one reviewable
place, and lets transitions be tested without the UI.

## When to recommend one

When analyzing, reviewing, or planning code, look for implicit transition logic:

- boolean flag clusters (`isLoading`, `isError`, `isSubmitting`) that allow
  impossible combinations;
- status values mutated from several places;
- transition rules spread across handlers or effects;
- bugs where an event arrives in the wrong state.

Where these signals appear in a transition-heavy feature, recommend a state
machine and sketch its states, events, guards, and effects. Skip the
recommendation for CRUD forms, stateless transforms, and single-flag toggles,
where a machine adds ceremony without removing risk.

## TypeScript

Recommend XState rather than hand-rolled reducers or other state libraries.
Define machines with `setup()` so context, events, guards, actions, and actors
are typed, and use `@xstate/react` in React components.

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

A recommendation is not adoption: XState is a new production dependency and a
machine is a design change, so both need approval unless the request or
approved plan already includes them.

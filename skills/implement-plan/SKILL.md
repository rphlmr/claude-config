---
name: implement-plan
description: Executes a complete, approved engineering plan through exactly one implementation agent. Use after planning is finished and material decisions are settled.
disable-model-invocation: true
---

# Implement Plan

Execute the current approved plan through exactly one implementation subagent.

This is an execution handoff. Do not perform another planning, investigation,
review, or implementation phase in the parent thread.

## Establish the implementation brief

Treat the approved plan as current.

### Pasted plan

When the invocation arguments contain a complete implementation plan:

- use that plan verbatim;
- do not summarize, restructure, normalize, or reinterpret it;
- include only explicit amendments stated after the plan.

### Plan from the current conversation

Otherwise:

- use the latest explicitly approved final plan from the current conversation;
- preserve its wording and structure;
- append only later explicit decisions or corrections;
- exclude exploratory discussion, rejected alternatives, superseded plans, and
  unrelated conversation.

Do not inspect the repository to verify plan freshness.

Do not recreate an already complete plan as a shorter brief. Rewriting can omit
important compatibility, validation, or acceptance details.

If no complete approved plan can be identified, stop. Do not create a new plan
under this skill.

Treat a plan as complete only when it contains, at the level required by the
task:

- a clear outcome;
- executable implementation boundaries or steps;
- settled material decisions and constraints;
- objectively checkable acceptance criteria;
- required validation commands or validation expectations.

For a simple change, these elements may be concise or combined. Do not require
ceremonial sections when the required information is already explicit.

If a material element is missing, stop and identify the missing element. Do not
infer, reconstruct, or repair the plan under this skill.

## Validation contract

Treat the validation specified by the approved plan as the complete required
validation set.

- Preserve exact validation commands when they are present in the approved plan
  or were explicitly added as a later approved amendment.
- Do not add broader test suites or validation categories.
- Do not remove or weaken required validation.
- Do not convert descriptive validation requirements into guessed commands in
  the parent thread.

The implementation agent may resolve exact repository commands when they were
not established during planning.

## Select the implementation agent

Select the implementation agent from the approved plan before spawning it.
`super-implementer` is the strongest executor for hard work, `implementer` the
default for contract-heavy work, and `light-implementer` the lighter executor
for narrow mechanical work.

Use `super-implementer` when the plan changes any of:

- authentication or security;
- persistence or data migrations;
- conditional, recursive, nominal, or inference-heavy TypeScript types, or
  public types whose inference the plan's acceptance criteria assert.

Also use `super-implementer` when the plan shows the task is hard:

- its correctness depends on several interacting subsystems at once, such as
  concurrency with persistence, or a state machine with workers and
  cancellation;
- it calls for new algorithmic or correctness-critical logic with no existing
  pattern in the repository to follow;
- `implementer` already attempted the same work and returned it incomplete, or
  a verifier failed it on correctness rather than on a named, exact fix.

Use `implementer` when the plan changes any of:

- exported or public APIs of a package or module;
- emitted declarations or a package's exports map;
- shared monorepo contracts;
- code shared by several targets, such as platform apps and their extensions,
  or runtime adapters;
- Swift concurrency: actor isolation, `Sendable` conformance, or main-actor
  boundaries;
- state machines, workers, or async lifecycles with cancellation;
- pinned dependencies, artifacts, or compatibility matrices;
- compatibility or migration surfaces;
- build infrastructure.

Use `light-implementer` for:

- localized runtime behavior;
- mechanical refactors with exact instructions;
- narrow UI changes within one target;
- documentation;
- repetitive test additions;
- corrections where a verifier has already identified the exact symbols and
  expected types.

When the plan has an `Implementation agent` section, check its categories
against the code the plan changes and use them. When categories overlap, the
stronger agent's criteria take precedence: `super-implementer`, then
`implementer`. When the plan leaves unclear whether a stronger agent's criteria
apply, choose the stronger agent. Honor an explicit user request for any
implementation agent.

Before spawning, state in one line the selected agent and the criterion that
matched.

Spawn exactly one selected implementation agent with the Agent tool, as a new
subagent of that type rather than a fork of this conversation:

- `super-implementer` for the security, data, type-level, and hard-task
  categories above;
- `implementer` for the contract-heavy categories above;
- `light-implementer` for the narrow and mechanical categories above.

Do not spawn additional implementation, exploration, planning, review, or
verification agents unless the user explicitly requests a separate review.

## Handoff

The agent starts without this conversation, so the handoff is its entire brief.
Send the selected agent this short execution contract:

> The following implementation plan is current, approved, and authoritative.
> Implement it directly under your standing agent instructions.
>
> Treat its validation section as the complete required validation set.

Append the approved implementation plan verbatim.

Do not duplicate the implementation agent's standing instructions in the
handoff.

Wait for the selected agent to return. Its result may arrive later as a
completion notification; do not report an outcome before it arrives.

Do not inspect, implement, validate, or review the same changes independently in
the parent thread.

## Material decision escalation

When the implementation agent returns `BLOCKED_DECISION`, the parent owns the
decision.

Use the reported repository evidence together with:

- the approved plan;
- explicit decisions already made;
- active instructions;
- the requested outcome.

When those establish one unambiguous answer:

1. make the decision in the parent thread;
2. send only the resolved decision to the same implementation agent with
   `SendMessage`, addressed by the agent ID or name from its result;
3. instruct that agent to continue.

Ask the user only when multiple valid outcomes still depend on product intent or
preference.

Do not:

- ask the implementation agent to choose an architecture;
- ask it to recommend between product or API alternatives;
- replace it because it escalated;
- spawn a second implementation agent;
- send the complete plan again unless the agent requests missing context.

## Completion

When the implementation agent completes:

- inspect its completion report and require:
  - one line for every acceptance criterion;
  - the concrete test, declaration, or behavior proving each criterion;
  - every exact required validation command and its result;
  - every declaration-inspection requirement and its result;
  - explicit `Unresolved` and `Unverified` sections, using `None` when empty;
- if any required report element is absent, send the same implementation agent
  a targeted follow-up with `SendMessage` identifying the missing report
  elements, and wait for its corrected completion report before proceeding;
- report the implementation agent used and the criterion that selected it;
- report the implementation outcome;
- include acceptance-criterion results;
- include validation commands and results;
- include deviations, unverified items, and unresolved issues;
- clearly state any failed required validation.

Do not redo the implementation or validation in the parent thread.

Do not claim successful completion when a required acceptance criterion remains
unsatisfied or required validation failed.

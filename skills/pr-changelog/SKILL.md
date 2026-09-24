---
name: pr-changelog
description: Writes a PR or MR description, review prep, release notes, or a changelog from the current branch's committed changes. Use when the user asks for PR or MR text, release notes, or a changelog for the current branch. Does not open a PR or cover uncommitted work.
---

# PR Changelog

Generate text through exactly one fresh `pr-changelog` subagent, spawned with the
Agent tool. It owns all Git inspection, comparison-target selection, merge-base
calculation, complete committed history and effective diff analysis, and the
final output.

Pass the user's request and explicit preferences in a concise brief: base branch,
mode, language, format, detail, review focus, audience, and compatibility emphasis.
Do not infer missing preferences or send unrelated conversation.

Supported modes are PR/MR description (default), review prep (description plus
reviewer guidance), release notes (externally observable changes), and changelog
only (complete change list without a summary).

Scope covers every committed change on the current local branch since its merge
base with the selected comparison target, including pushed and unpushed commits.
It excludes staged, unstaged, and untracked work. If the user requires uncommitted
work, output exactly:

PR-changelog supports committed branch changes only.

A different workflow is required to summarize uncommitted work.

The parent does not run Git commands, inspect the repository, choose the base,
perform a competing analysis, revise the result, or spawn another agent. This
workflow does not modify Git state or open or update a PR/MR.

Wait for the agent's result, which may arrive later as a completion notification.
Return its response unchanged, including its grouping, compatibility, validation,
dirty-repository, and review-focus notes. Add no framing or commentary. If the
agent is unavailable, return exactly:

PR-changelog agent unavailable.

Do not fall back to parent-thread Git analysis.

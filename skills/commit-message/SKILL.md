---
name: commit-message
description: Generates one single-line Conventional Commit message from the staged diff, without committing. Use when the user asks for a commit message for staged changes.
---

# Commit Message

Generate text from the staged Git diff through exactly one fresh `commit-message`
subagent, spawned with the Agent tool. The agent owns repository inspection,
message selection, the 50-character limit, and handling an empty staged diff.

Ask it to inspect the staged changes and follow its standing output contract.
Do not supply proposed wording, a commit type, or assumptions about the changes.

The parent does not run Git commands, inspect the repository or history, draft a
competing message, revise the result, or spawn another agent. This workflow does
not stage, commit, or modify files.

Wait for the agent's result, which may arrive later as a completion
notification. Return its exact output with no Markdown, framing, alternatives, or
commentary. If the agent is unavailable, return exactly:

Commit-message agent unavailable.

Do not fall back to parent-thread analysis.

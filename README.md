# Claude Config

Personal Claude Code skills, custom agents, global instructions, and global rules
tracked in Git.
It is the Claude Code counterpart of [rphlmr/codex](https://github.com/rphlmr/codex),
forked from its `9d8fc63` revision.

This repository is the source of truth for:

- custom skills;
- custom agents (subagents);
- global `CLAUDE.md`;
- global rules.

It does not manage Claude Code settings: `~/.claude/settings.json` stays under
your own control.

## Installation

Clone the repository:

```bash
mkdir -p ~/workspace

git clone git@github.com:rphlmr/claude-config.git ~/workspace/claude-config
cd ~/workspace/claude-config
```

Make the management scripts executable:

```bash
chmod +x sync-skills.sh sync-claude-md.sh
```

Synchronize skills, custom agents, global instructions, and rules:

```bash
./sync-skills.sh
./sync-claude-md.sh
```

Start a new Claude Code session afterwards. A running session doesn't reload
`CLAUDE.md`, and it only watches an agents directory that existed when it
started, so the first sync of `~/.claude/agents/` needs a restart.

The resulting layout is:

```text
                              Git repository
                                     │
                         ~/workspace/claude-config
                                     │
         ┌──────────────────┬────────┴─────────┬──────────────────┐
         │                  │                  │                  │
      skills/            agents/           CLAUDE.md           rules/
         │                  │                  │                  │
       copy               copy               copy               copy
         │                  │                  │                  │
         ▼                  ▼                  ▼                  ▼
~/.claude/skills/* ~/.claude/agents/* ~/.claude/CLAUDE.md ~/.claude/rules/*
```

Both scripts honor `CLAUDE_CONFIG_DIR` when you have moved the Claude Code
configuration directory.

In this repository, `.claude/settings.json` excludes the root `CLAUDE.md` with
`claudeMdExcludes`, so sessions here don't load the global instructions twice
(once from `~/.claude/CLAUDE.md` and once as project instructions).
`.claude/CLAUDE.md` supplies the repository-specific guidance instead. The
exclusion patterns assume the clone directory is named `claude-config`.

## Repository structure

```text
.
├── CLAUDE.md
├── .claude/
│   ├── CLAUDE.md
│   ├── settings.json
│   └── skills/
│       └── release-commit-message/
├── agents/
│   ├── commit-message.md
│   ├── future-architect.md
│   ├── implementer.md
│   ├── light-implementer.md
│   ├── pr-changelog.md
│   └── verifier.md
├── rules/
│   ├── react.md
│   └── typescript.md
├── skills/
│   ├── commit-message/
│   │   ├── SKILL.md
│   │   └── evals/
│   ├── final-implementation-plan/
│   ├── future-architect-mode/
│   ├── implement-plan/
│   ├── markdown-output/
│   ├── pr-changelog/
│   ├── session-handoff/
│   ├── state-machines/
│   └── verify-implementation/
├── sync-skills.sh
├── sync-claude-md.sh
└── README.md
```

## Included skills

| Skill                        | Purpose                                                                                        | Claude can invoke it | Custom agent                                                                              |
| ---------------------------- | ---------------------------------------------------------------------------------------------- | -------------------- | ----------------------------------------------------------------------------------------- |
| `/commit-message`            | Generate one Conventional Commit message from the staged diff.                                 | Yes                  | `commit-message`                                                                          |
| `/final-implementation-plan` | Finalize a completed plan mode result into a self-contained implementation handoff.            | No                   | None                                                                                      |
| `/future-architect-mode`     | Independently review an idea, design, architecture, or implementation plan.                    | No                   | `future-architect`                                                                        |
| `/implement-plan`            | Execute a complete approved plan with one implementation agent.                                | No                   | Routes contract-heavy work to `implementer`; narrow mechanical work to `light-implementer` |
| `/markdown-output`           | Return copyable Markdown as one intact block with balanced fences.                             | Yes                  | None                                                                                      |
| `/pr-changelog`              | Generate PR/MR text, review prep, release notes, or a changelog from committed branch changes. | Yes                  | `pr-changelog`                                                                            |
| `/session-handoff`           | Create a self-contained prompt for continuing established work in a fresh Claude Code session. | No                   | None                                                                                      |
| `/state-machines`            | Recommend and sketch explicit state machines for features driven by state transitions.        | Yes                  | None; preloaded into `future-architect`                                                   |
| `/verify-implementation`     | Independently verify completed work against the approved plan and acceptance criteria.         | No                   | `verifier`                                                                                |

Skills that Claude can't invoke set `disable-model-invocation: true`, the
counterpart of Codex's `allow_implicit_invocation: false`. Type the command at the
start of a message to run them, for example `/implement-plan`.

The repository-local `release-commit-message` skill lives in
`.claude/skills/` and loads only in sessions inside this repository.

The repository provides these custom agents:

| Definition                    | Agent name          | Model and effort        | Tools                                               |
| ----------------------------- | ------------------- | ----------------------- | --------------------------------------------------- |
| `agents/commit-message.md`    | `commit-message`    | Claude Sonnet 5, low    | `Bash` only                                         |
| `agents/future-architect.md`  | `future-architect`  | Claude Opus 5.5, high   | Inherited, minus file edits and `Agent`             |
| `agents/implementer.md`       | `implementer`       | Claude Opus 5.5, medium | Inherited, minus `Agent`, `WebFetch`, `WebSearch`   |
| `agents/light-implementer.md` | `light-implementer` | Claude Sonnet 5, medium | Inherited, minus `Agent`, `WebFetch`, `WebSearch`   |
| `agents/pr-changelog.md`      | `pr-changelog`      | Claude Sonnet 5, medium | `Bash`, `Read`, `Grep`, `Glob`                      |
| `agents/verifier.md`          | `verifier`          | Claude Opus 5.5, high   | Inherited, minus file edits, web tools, and `Agent` |

No agent can spawn subagents, which keeps each workflow at its documented agent
count. Agents inherit the invoking session's permission mode; tool lists and the
agents' instructions keep the read-only roles read-only. Each agent's
`description` limits it to its workflow so Claude doesn't delegate to it on its
own.

Subagents load your `CLAUDE.md` files by default. `commit-message` sets
`omitClaudeMd: true` because it needs only the staged diff and its fixed format
ignores project conventions. `future-architect` preloads the `state-machines`
skill with `skills:`.

## Model configuration

Reviewed on September 24, 2026 against the official
[Claude Code subagent reference](https://code.claude.com/docs/en/sub-agents),
[skills reference](https://code.claude.com/docs/en/skills),
[model configuration](https://code.claude.com/docs/en/model-config),
[effort](https://platform.claude.com/docs/en/build-with-claude/effort), and
[Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5).

| Codex role          | Codex model        | Claude model      | Claude effort |
| ------------------- | ------------------ | ----------------- | ------------- |
| `implementer`       | GPT-6 Sol, medium  | `claude-opus-5-5` | `medium`      |
| `future_architect`  | GPT-6 Sol, medium  | `claude-opus-5-5` | `high`        |
| `verifier`          | GPT-6 Sol, medium  | `claude-opus-5-5` | `high`        |
| `light_implementer` | GPT-6 Luna, xhigh  | `claude-sonnet-5` | `medium`      |
| `pr_changelog`      | GPT-6 Luna, medium | `claude-sonnet-5` | `medium`      |
| `commit_message`    | GPT-6 Luna, low    | `claude-sonnet-5` | `low`         |

- Models are pinned by full ID, not the `opus` or `sonnet` aliases, because the
  prompts are tuned for these versions and an alias moves when a new model ships.
- Sonnet 5 takes the Luna roles as the lighter, cheaper model. Haiku 4.5 has no
  effort control and retires no sooner than October 15, 2026.
- Effort levels aren't carried over from Codex: the effort scale is calibrated
  per model, so the same level name means a different amount of thinking on
  each model. Each level follows the official guidance instead. `implementer`
  starts at `medium`, Opus 5.5's default, which matched or beat Opus 5 at
  `high` on agentic coding. `verifier` and `future-architect` use `high`, the
  level listed for complex reasoning. `light-implementer` and `pr-changelog` use
  `medium`, Sonnet 5's cost-saving step-down, and `commit-message` uses `low`
  for a short, latency-sensitive task.
- The Opus 5.5 guide reserves `xhigh` and `max` for work where you've measured
  a quality gain. Raise an agent only after an effort sweep on your own tasks
  shows one.
- `effort` in agent frontmatter overrides the session's effort level while the
  agent runs, but not the `CLAUDE_CODE_EFFORT_LEVEL` environment variable. Leave
  that variable unset, or every agent runs at its value.
- Run `/tasks` while an agent works to confirm its model and effort level.

## Prompt maintenance

The global instructions and agent prompts follow the Opus 5.5 prompting guide:

- Thinking is always on and `effort` is the control for its depth, so no prompt
  asks the model to think harder or to write its reasoning into the response.
  The latter can be declined with the `reasoning_extraction` refusal category.
- A subagent's final message is its result, so an Opus 5.5 agent that ends a turn
  with a progress summary hands back unfinished work. `implementer`,
  `light-implementer`, and `verifier` name the early stops to avoid and the
  stops that are wanted, as the guide recommends for unattended runs.
- No prompt relies on a todo list. Claude Code provides the task-tracking tools
  by default only on older models (up to Opus 4.7 and Sonnet 4.6), and a
  subagent gets them only when the main session has them.
- `CLAUDE.md` caps delegation at one subagent per request unless you ask for
  more (three when you give no number), including inside skills and built-in
  commands such as `/code-review` that fan out agents.
- `CLAUDE.md` bounds task scope, and adds no generic
  "double-check your work" steps, which cause over-verification on Opus 5.x.
- `CLAUDE.md` holds only what every session needs and stays under the 200-line
  target from the official memory documentation, counted with lines wrapped at
  80 columns. TypeScript and React rules live in `rules/` with `paths:`
  frontmatter, so they load only when Claude reads matching files, and the state
  machine and copyable-Markdown guidance are skills.

The Codex-specific package-manager proxy workaround was removed from the
implementer and verifier prompts; it compensated for variables injected by
Codex's network proxy.

### State machine preference

The `state-machines` skill asks Claude to recommend explicit state machines when
analysis, review, or planning finds transition-heavy logic: XState for
TypeScript, and an in-house XState-style machine with no third-party library for
SwiftUI. `CLAUDE.md` points review and planning work at the skill, and
`future-architect` preloads it. A recommendation never adds XState or
restructures code without approval.

## Source of truth

Always edit files in this repository.

Canonical paths:

```text
~/workspace/claude-config/CLAUDE.md
~/workspace/claude-config/agents/*
~/workspace/claude-config/rules/*
~/workspace/claude-config/skills/*
```

The copies under `~/.claude` are generated from this repository and should not be
treated as canonical.

## What is synchronized

### Skills

Repository skills live under `./skills/`. `sync-skills.sh` copies them into
`~/.claude/skills/`:

```text
~/workspace/claude-config/skills/commit-message
        ↓ copy
~/.claude/skills/commit-message
```

Only skills present in this repository are replaced. Other entries, such as
`~/.claude/skills/synced` (skills synced from your claude.ai account), are left
untouched.

### Custom agents

Custom agent definitions live under `./agents/`. `sync-skills.sh` also copies them
into `~/.claude/agents/`:

```text
~/workspace/claude-config/agents/verifier.md
        ↓ copy
~/.claude/agents/verifier.md
```

### Global `CLAUDE.md`

The canonical global instructions live at `./CLAUDE.md`. `sync-claude-md.sh`
copies them into `~/.claude/CLAUDE.md`, which Claude Code loads in every project
as user instructions. The script copies only when the contents differ.

### Global rules

Rules live under `./rules/`. `sync-claude-md.sh` also copies them into
`~/.claude/rules/`, again only when the contents differ. Each rule sets `paths:`
frontmatter, so Claude Code loads it only when Claude reads a matching file.
Only rule files present in this repository are replaced.

## `sync-skills.sh`

`sync-skills.sh` synchronizes both:

```text
skills/*    → ~/.claude/skills/*
agents/*.md → ~/.claude/agents/*.md
```

It copies files and directories rather than using symlinks, so Claude Code always
works with normal local files under `~/.claude`.

The script:

1. resolves the repository directory;
2. creates `~/.claude/skills` and `~/.claude/agents` if necessary;
3. copies every repository skill into `~/.claude/skills`, skipping directories
   without a `SKILL.md`, such as eval workspaces;
4. copies every repository custom agent into `~/.claude/agents`;
5. replaces only entries whose names exist in this repository;
6. leaves unrelated Claude Code files untouched.

## Typical workflow

### Update a skill

```bash
$EDITOR skills/commit-message/SKILL.md
./sync-skills.sh
git diff
git add skills/commit-message
git commit
```

### Update a custom agent

```bash
$EDITOR agents/verifier.md
./sync-skills.sh
git diff
git add agents/verifier.md
git commit
```

Claude Code picks up agent edits in `~/.claude/agents/` within a few seconds, with
no restart.

### Update global instructions or rules

```bash
$EDITOR CLAUDE.md  # or rules/<topic>.md
./sync-claude-md.sh
git diff
git add CLAUDE.md rules
git commit
```

The new instructions apply from the next session, or after `/clear` or
`/compact`.

## Adding a new skill

Create a directory under `skills/` with a `SKILL.md`:

```text
skills/my-skill/
└── SKILL.md
```

The directory name becomes the command (`/my-skill`). Then run `./sync-skills.sh`
and commit the directory.

## Adding a new rule

Create `rules/<topic>.md` with `paths:` frontmatter listing the file globs it
applies to, followed by the rule text. Then run `./sync-claude-md.sh` and commit
the file. A rule without `paths:` loads in every session, like `CLAUDE.md`.

## Evaluating skills

The skills Claude can invoke on its own carry starter evals in
`evals/evals.json`, in the
[Agent Skills eval format](https://agentskills.io/skill-creation/evaluating-skills):
realistic prompts with expected outputs. Cases that need a Git repository in a
known state add a `setup` command that builds one in an empty directory.

To run them, ask Claude to evaluate a skill with the `skill-creator` skill. It
runs each prompt with and without the skill in fresh subagents and writes
results to a `<skill>-workspace/` directory next to the skill, which Git and
`sync-skills.sh` ignore. Sync first: `commit-message` and `pr-changelog`
delegate to their agents.

The workflow skills Claude can't invoke depend on a plan approved earlier in the
conversation, which this single-prompt format doesn't model, so they have no
evals yet.

## Adding a new custom agent

Create `agents/new-agent.md` with YAML frontmatter (`name` and `description` are
required) followed by the agent's system prompt. Then run `./sync-skills.sh` and
commit the file.

## Updating another machine

Record the current revision and pull the latest changes:

```bash
cd ~/workspace/claude-config
previous_revision="$(git rev-parse HEAD)"
git pull --ff-only
```

Review the release notes and the commits received by the pull:

```bash
cat CHANGELOG.md
git log --oneline "$previous_revision..HEAD"
git diff --stat "$previous_revision..HEAD"
```

Then synchronize:

```bash
./sync-skills.sh
./sync-claude-md.sh
```

Run the review commands before performing another Git operation that changes
`HEAD`. If the pull reports that the repository is already up to date, the log
and diff are empty.

## Versioning and releases

Releases are automated by
[Release Please](https://github.com/googleapis/release-please-action). It uses
Conventional Commits merged into `main` to maintain `CHANGELOG.md`, update
`version.txt`, propose the next Semantic Version, create the Git tag, and publish
the GitHub Release.

Use these commit types for user-visible changes:

- `fix:` proposes a patch release;
- `feat:` proposes a minor release;
- `feat!:` or a `BREAKING CHANGE:` footer proposes a breaking release.

Before `v1.0.0`, breaking changes increment the minor version. Other commit types,
such as `docs:`, `test:`, and `chore:`, do not trigger a release by themselves.

Do not edit release entries in `CHANGELOG.md` or versions in `version.txt`
manually. Release Please owns both files.

### Automated release flow

1. Merge one or more Conventional Commits into `main`.
2. The `Release Please` GitHub Actions workflow opens or updates a release PR.
3. Review the proposed version and generated changelog in that PR.
4. Merge the release PR when the changes should be published.
5. The workflow creates the `vX.Y.Z` tag and corresponding GitHub Release.

The repository is bootstrapped at `0.0.0`, so the first merged `feat:` change
proposes `v0.1.0`.

### One-time GitHub configuration

In the repository, open **Settings → Actions → General**. Under **Workflow
permissions**, enable **Read and write permissions** and allow GitHub Actions to
create pull requests. The workflow uses the repository-provided `GITHUB_TOKEN`;
no custom secret is required.

If branch or tag protection rules are enabled, they must also allow the GitHub
Actions bot to create the release PR and version tag.

## Copy semantics

Synchronization is intentionally one-way:

```text
repository
    ↓
~/.claude
```

Changes made directly under:

```text
~/.claude/skills
~/.claude/agents
~/.claude/rules
~/.claude/CLAUDE.md
```

may be overwritten the next time the corresponding sync script runs.

If you modify something directly under `~/.claude` and want to keep it, copy the
change back into the repository before synchronizing again.

## Repository scope

This repository manages:

```text
~/.claude/CLAUDE.md
~/.claude/agents/*
~/.claude/rules/*
~/.claude/skills/*
```

It never reads or writes `~/.claude/settings.json`.

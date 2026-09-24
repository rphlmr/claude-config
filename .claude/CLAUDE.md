# Repository guidance

This repository stores the source of the global Claude Code instructions
(`CLAUDE.md`), global rules (`rules/`), custom agents (`agents/`), and skills
(`skills/`). The sync scripts copy them into `~/.claude`. `.claude/settings.json` keeps the root `CLAUDE.md` out
of this repository's own context, so treat it as a file under edit, not as active
instructions.

- Keep README descriptions and agent or skill metadata aligned with the files they describe.
- Frontmatter field names must match the official subagent, skill, and rule references exactly; Claude Code ignores unknown fields without an error.
- Keep the root `CLAUDE.md` under 200 lines, the official size target for a CLAUDE.md file, with every line wrapped at 80 columns so the count reflects its real size.
- Run `sync-skills.sh` or `sync-claude-md.sh` only when the user asks; they overwrite files under `~/.claude`.

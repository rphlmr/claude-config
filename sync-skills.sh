#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

SKILLS_SOURCE="$REPO_DIR/skills"
AGENTS_SOURCE="$REPO_DIR/agents"

SKILLS_TARGET="$CLAUDE_DIR/skills"
AGENTS_TARGET="$CLAUDE_DIR/agents"

mkdir -p "$SKILLS_TARGET"
mkdir -p "$AGENTS_TARGET"

sync_directory_entries() {
  local source_dir="$1"
  local target_dir="$2"

  [[ -d "$source_dir" ]] || return

  for source in "$source_dir"/*; do
    # Skip eval workspaces and anything else that isn't a skill.
    [[ -f "$source/SKILL.md" ]] || continue

    local name
    name="$(basename "$source")"

    local target="$target_dir/$name"

    rm -rf "$target"
    cp -R "$source" "$target"

    echo "Synced: $target"
  done
}

sync_directory_entries "$SKILLS_SOURCE" "$SKILLS_TARGET"

for source in "$AGENTS_SOURCE"/*.md; do
  [[ -e "$source" ]] || continue

  name="$(basename "$source")"
  target="$AGENTS_TARGET/$name"

  cp "$source" "$target"

  echo "Synced: $target"
done

echo
echo "Claude Code skills and agents synced."

#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

SOURCE="$REPO_DIR/CLAUDE.md"
TARGET="$CLAUDE_DIR/CLAUDE.md"

RULES_SOURCE="$REPO_DIR/rules"
RULES_TARGET="$CLAUDE_DIR/rules"

if [[ ! -f "$SOURCE" ]]; then
  echo "Missing source file: $SOURCE" >&2
  exit 1
fi

copy_if_changed() {
  local source="$1"
  local target="$2"

  if [[ -f "$target" ]] && cmp -s "$source" "$target"; then
    echo "Already up to date: $target"
    return
  fi

  cp "$source" "$target"

  echo "Updated: $target"
}

mkdir -p "$CLAUDE_DIR"

copy_if_changed "$SOURCE" "$TARGET"

if [[ -d "$RULES_SOURCE" ]]; then
  mkdir -p "$RULES_TARGET"

  for source in "$RULES_SOURCE"/*.md; do
    [[ -e "$source" ]] || continue

    copy_if_changed "$source" "$RULES_TARGET/$(basename "$source")"
  done
fi

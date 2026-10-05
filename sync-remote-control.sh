#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$REPO_DIR/remote-control"

BIN_TARGET="$HOME/.local/bin"
CONFIG_FILE="$HOME/.config/claude-rc/projects"

copy_if_changed() {
  local source="$1"
  local target="$2"

  if [[ -f "$target" ]] && cmp -s "$source" "$target"; then
    echo "Already up to date: $target"
    return
  fi

  cp "$source" "$target"
  chmod +x "$target"

  echo "Updated: $target"
}

mkdir -p "$BIN_TARGET"

copy_if_changed "$SOURCE_DIR/claude-rc" "$BIN_TARGET/claude-rc"

if [[ ! -f "$CONFIG_FILE" ]]; then
  mkdir -p "$(dirname "$CONFIG_FILE")"
  printf '%s\n' \
    "# One project directory per line. Lines starting with # are ignored." \
    "# ~/workspace/my-project" >"$CONFIG_FILE"

  echo "Created: $CONFIG_FILE"
fi

plugin_dir="$(defaults read com.ameba.SwiftBar PluginDirectory 2>/dev/null || true)"

if [[ -n "$plugin_dir" ]]; then
  copy_if_changed "$SOURCE_DIR/swiftbar/claude-rc.10s.sh" "${plugin_dir%/}/claude-rc.10s.sh"
else
  echo "Skipped SwiftBar plugin: SwiftBar has no plugin folder yet (open SwiftBar once)."
fi

agent_label="local.claude-rc"
agent_target="$HOME/Library/LaunchAgents/$agent_label.plist"
agent_rendered="$(mktemp)"

sed "s|__HOME__|$HOME|g" "$SOURCE_DIR/launchd/$agent_label.plist" >"$agent_rendered"
mkdir -p "$(dirname "$agent_target")" "$HOME/.local/state/claude-rc"

if [[ -f "$agent_target" ]] && cmp -s "$agent_rendered" "$agent_target"; then
  echo "Already up to date: $agent_target"
else
  cp "$agent_rendered" "$agent_target"

  # Reload so launchd reads the new plist; RunAtLoad starts the servers now.
  launchctl bootout "gui/$(id -u)/$agent_label" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$agent_target"

  echo "Updated and loaded: $agent_target"
fi

rm -f "$agent_rendered"

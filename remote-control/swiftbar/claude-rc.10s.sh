#!/usr/bin/env bash
# <swiftbar.title>Claude Remote Control</swiftbar.title>
# <swiftbar.desc>Start and stop `claude remote-control` servers per project.</swiftbar.desc>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>

set -uo pipefail

CLAUDE_RC="$HOME/.local/bin/claude-rc"
CONFIG_FILE="${CLAUDE_RC_CONFIG:-$HOME/.config/claude-rc/projects}"

# Clawd with and without signal arcs. Regenerate with icon.py.
ICON_ON='iVBORw0KGgoAAAANSUhEUgAAAC4AAAAkCAYAAAD2IghRAAAACXBIWXMAABYlAAAWJQFJUiTwAAAA2ElEQVR42mNgGAWjYOSB/zTGI8Lh84E4Yag5PAFJj8FQcvh5JD3vgVhgqDhcAepgmL75g9nhBmgh64CmV4EUh5PrIULmYXM0KIT3o4mvJzbUB8rhyGm6AM1DyGl90Dm8AY8D7yPJOQw2h6M7MABJvB9JvIFemZGUzIoc6v1I4gXY0vlgcjhyKbKfkPiow+mdVAZTBURS5hwsDqd6cUgvh1O9AqKXw6le5Q/ZRtaQadaiewAXn9r6KO5IDBaHk9x1GywOJ7mzPJgcTtEwxajDR8EoGAWjYPACAIppg/sLARCqAAAAAElFTkSuQmCC'
ICON_OFF='iVBORw0KGgoAAAANSUhEUgAAAC4AAAAkCAYAAAD2IghRAAAACXBIWXMAABYlAAAWJQFJUiTwAAAATElEQVR42u3VQQoAEBBAUfe/9DiBRGYU79csLOjZ0Jr0X5E84ODgv8N3LzQ7Dxy8Ch6XBxy8+l33c4KDg+deYLQ+vQ8cHPx1uCSt1wG/Ch3/ZYswmAAAAABJRU5ErkJggg=='

if [[ ! -x "$CLAUDE_RC" ]]; then
  echo "| sfimage=exclamationmark.triangle"
  echo "---"
  echo "claude-rc not installed, run sync-remote-control.sh"
  exit 0
fi

status="$("$CLAUDE_RC" status 2>/dev/null)"
running="$(printf '%s\n' "$status" | awk -F'\t' '$2 == "running"' | grep -c . || true)"

if [[ "$running" -gt 0 ]]; then
  echo "$running | templateImage=$ICON_ON"
else
  echo "| templateImage=$ICON_OFF"
fi

echo "---"

if [[ -z "$status" ]]; then
  echo "No projects in $CONFIG_FILE | color=gray"
fi

while IFS=$'\t' read -r name state _pids dir; do
  [[ -n "$name" ]] || continue
  log="$("$CLAUDE_RC" log "$name")"

  if [[ "$state" == "running" ]]; then
    echo "$name | sfimage=circle.fill sfcolor=#34C759"
    echo "--Stop | bash=$CLAUDE_RC param1=stop param2=$name terminal=false refresh=true"
  else
    echo "$name | sfimage=circle sfcolor=#8E8E93"
    echo "--Start | bash=$CLAUDE_RC param1=start param2=$name terminal=false refresh=true"
  fi

  echo "--Reveal in Finder | bash=/usr/bin/open param1=\"$dir\" terminal=false"
  echo "--Show log | bash=/usr/bin/open param1=-a param2=Console param3=\"$log\" terminal=false"
done <<<"$status"

echo "---"
echo "Start all | bash=$CLAUDE_RC param1=start terminal=false refresh=true"
echo "Stop all | bash=$CLAUDE_RC param1=stop terminal=false refresh=true"
echo "---"
echo "Open Claude Code | bash=/usr/bin/open param1=claude://code/new terminal=false"
echo "Edit projects… | bash=/usr/bin/open param1=-t param2=\"$CONFIG_FILE\" terminal=false"

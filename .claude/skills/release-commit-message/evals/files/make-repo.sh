#!/usr/bin/env bash
# Builds a throwaway Git repository in the current, empty directory for one
# eval scenario: staged (a new flag, a bug fix, and its docs are staged) or
# unstaged-only.

set -euo pipefail

scenario="${1:-}"

case "$scenario" in
  staged | unstaged-only) ;;
  *)
    echo "Usage: make-repo.sh staged|unstaged-only" >&2
    exit 1
    ;;
esac

if [[ -n "$(ls -A)" ]]; then
  echo "Run this in an empty directory." >&2
  exit 1
fi

git init -q -b main
git config user.name "Eval Fixture"
git config user.email "eval@example.com"
git config commit.gpgsign false

mkdir -p src

cat > src/cli.ts <<'EOF'
export interface CliOptions {
  input: string;
}

export function parseArgs(argv: string[]): CliOptions {
  return { input: argv[0] ?? "." };
}
EOF

cat > src/date.ts <<'EOF'
export function parseDay(value: string): Date {
  return new Date(value);
}
EOF

printf '# sync-tool\n\nUsage: sync-tool <input>\n' > README.md

git add .
git commit -q --no-verify -m "chore: initial commit"

cat > src/cli.ts <<'EOF'
export interface CliOptions {
  input: string;
  dryRun: boolean;
}

export function parseArgs(argv: string[]): CliOptions {
  const dryRun = argv.includes("--dry-run");
  const input = argv.find((arg) => !arg.startsWith("--")) ?? ".";

  return { input, dryRun };
}
EOF

cat > src/date.ts <<'EOF'
export function parseDay(value: string): Date {
  const [year, month, day] = value.split("-").map(Number);

  return new Date(Date.UTC(year, month - 1, day));
}
EOF

printf '# sync-tool\n\nUsage: sync-tool [--dry-run] <input>\n\n`--dry-run` prints the planned changes without writing them.\n' > README.md

if [[ "$scenario" == "staged" ]]; then
  git add src/cli.ts src/date.ts README.md
fi

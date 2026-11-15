#!/usr/bin/env bash
# Install the hardware profile into a Claude Code user directory by symlink,
# so `git pull` in this repository updates every machine and project at once.
#
# Links created under TARGET (default ~/.claude):
#   hardware                 -> <repo>/profiles/hardware        (workflow, prompts, snippet)
#   rules/hardware-design.md -> <repo>/profiles/hardware/rules/hardware-design.md
#                                (path-scoped: loads only when a CAD/fab file is read or edited)
#   hardware-learnings       -> LEARNINGS_DIR (default <repo>/learnings)
#
# Never writes TARGET/CLAUDE.md. Never deletes: anything in the way is moved to
# <name>.bak-<timestamp> first. Re-running is a no-op when links are already correct.
#
# Usage: install.sh [--dry-run] [--target DIR] [--learnings-dir DIR] [--help]
#        LEARNINGS_DIR=/path/to/private/learnings ./install.sh

set -euo pipefail

usage() {
  sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'
}

DRY_RUN=0
TARGET="${HOME}/.claude"
REPO_DIR="$(cd "$(dirname "$0")" && pwd -P)"
LEARNINGS_DIR="${LEARNINGS_DIR:-${REPO_DIR}/learnings}"

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --target)
      [ $# -ge 2 ] || { echo "error: --target needs a directory" >&2; exit 2; }
      TARGET="$2"; shift ;;
    --learnings-dir)
      [ $# -ge 2 ] || { echo "error: --learnings-dir needs a directory" >&2; exit 2; }
      LEARNINGS_DIR="$2"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

PROFILE_DIR="${REPO_DIR}/profiles/hardware"
RULE_SRC="${PROFILE_DIR}/rules/hardware-design.md"
STAMP="$(date +%Y%m%d%H%M%S)"
CHANGED=0

say() { printf '%s\n' "$*"; }
run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    say "  would: $*"
  else
    "$@"
  fi
}

# Resolve where a symlink points without following chains (portable: no readlink -f on macOS bash 3.2).
link_target() { readlink "$1" 2>/dev/null || true; }

# link SRC DST: ensure DST is a symlink to SRC. Back up anything else that is there.
link() {
  local src="$1" dst="$2" cur
  if [ -L "$dst" ]; then
    cur="$(link_target "$dst")"
    if [ "$cur" = "$src" ]; then
      say "ok      $dst -> $src"
      return 0
    fi
    say "relink  $dst (was -> $cur)"
    run mv "$dst" "${dst}.bak-${STAMP}"
    say "  backup ${dst}.bak-${STAMP}"
  elif [ -e "$dst" ]; then
    say "backup  $dst -> ${dst}.bak-${STAMP} (existing file/dir kept, not overwritten)"
    run mv "$dst" "${dst}.bak-${STAMP}"
  else
    say "link    $dst -> $src"
  fi
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
  CHANGED=1
}

# Preconditions
for p in "$PROFILE_DIR" "$RULE_SRC" "${PROFILE_DIR}/workflow.md"; do
  [ -e "$p" ] || { echo "error: missing $p (run from a checkout of ai-coding-workflow)" >&2; exit 1; }
done
if ! head -n 1 "$RULE_SRC" | grep -q '^---$'; then
  echo "error: $RULE_SRC has no YAML frontmatter; an unscoped user rule would load in every project" >&2
  exit 1
fi
if ! grep -q '^paths:' "$RULE_SRC"; then
  echo "error: $RULE_SRC frontmatter has no 'paths:' key; refusing to install an unscoped global rule" >&2
  exit 1
fi
if [ ! -d "$LEARNINGS_DIR" ]; then
  echo "error: learnings dir does not exist: $LEARNINGS_DIR" >&2
  exit 1
fi

[ "$DRY_RUN" -eq 1 ] && say "DRY RUN: no files will be changed"
say "repo:      $REPO_DIR"
say "target:    $TARGET"
say "learnings: $LEARNINGS_DIR"
say ""

run mkdir -p "$TARGET" "${TARGET}/rules"
link "$PROFILE_DIR"   "${TARGET}/hardware"
link "$RULE_SRC"      "${TARGET}/rules/hardware-design.md"
link "$LEARNINGS_DIR" "${TARGET}/hardware-learnings"

say ""
if [ -e "${TARGET}/CLAUDE.md" ] || [ -L "${TARGET}/CLAUDE.md" ]; then
  say "note: ${TARGET}/CLAUDE.md exists and was left untouched (this installer never writes it)."
else
  say "note: no ${TARGET}/CLAUDE.md created; the hardware rule is path-scoped and the upstream software CLAUDE.md is not installed globally."
fi
if [ "$DRY_RUN" -eq 1 ]; then
  say "dry run complete; nothing was changed."
elif [ "$CHANGED" -eq 1 ]; then
  say "done. Per-project hook-up: see ${PROFILE_DIR}/PROJECT-SNIPPET.md"
else
  say "nothing to do; already installed."
fi
say "verify in Claude Code: /context all (memory files), /doctor prompt-audit, or claude --debug for rule frontmatter errors."

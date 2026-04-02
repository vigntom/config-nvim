#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEST="$REPO_ROOT/cursor-user"
SRC_CURSOR="$HOME/.cursor"
SRC_SETTINGS="$HOME/.config/Cursor/User/settings.json"

mkdir -p "$DEST/skills" "$DEST/agents" "$DEST/commands" "$DEST/settings"

echo "Syncing skills..."
rsync -a --delete \
  --include='*/' \
  --include='SKILL.md' \
  --exclude='*' \
  "$SRC_CURSOR/skills/" "$DEST/skills/"

echo "Syncing agents..."
rsync -a --delete \
  --include='*.md' \
  --exclude='*' \
  "$SRC_CURSOR/agents/" "$DEST/agents/"

echo "Syncing commands..."
rsync -a --delete \
  --include='*.md' \
  --exclude='*' \
  "$SRC_CURSOR/commands/" "$DEST/commands/"

if [[ -f "$SRC_SETTINGS" ]]; then
  echo "Syncing settings.json..."
  cp "$SRC_SETTINGS" "$DEST/settings/settings.json"
else
  echo "Warning: settings file not found at $SRC_SETTINGS" >&2
fi

echo "Sync complete: $DEST"

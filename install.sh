#!/usr/bin/env bash
# Install these skills by symlinking them into a Claude Code skills directory.
# Symlinks mean the installed copy and this repository can't drift.
#
#   ./install.sh                  install for your user (~/.claude/skills)
#   ./install.sh --project DIR    install into DIR/.claude/skills
#   ./install.sh --uninstall      remove the symlinks this script created
#   ./install.sh --list           show what's installed

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO/skills"
TARGET="$HOME/.claude/skills"
ACTION="install"

while [ $# -gt 0 ]; do
  case "$1" in
    --project)
      [ $# -ge 2 ] || { echo "--project needs a directory" >&2; exit 2; }
      TARGET="$(cd "$2" && pwd)/.claude/skills"
      shift 2
      ;;
    --uninstall) ACTION="uninstall"; shift ;;
    --list)      ACTION="list";      shift ;;
    -h|--help)   sed -n '2,9p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)           echo "unknown option: $1" >&2; exit 2 ;;
  esac
done

[ -d "$SRC" ] || { echo "no skills directory at $SRC" >&2; exit 1; }

skills() { find "$SRC" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort; }

case "$ACTION" in
  list)
    for name in $(skills); do
      link="$TARGET/$name"
      if [ -L "$link" ]; then
        printf '%-28s -> %s\n' "$name" "$(readlink "$link")"
      elif [ -e "$link" ]; then
        printf '%-28s (a real directory, not ours)\n' "$name"
      else
        printf '%-28s not installed\n' "$name"
      fi
    done
    ;;

  uninstall)
    removed=0
    for name in $(skills); do
      link="$TARGET/$name"
      if [ -L "$link" ] && [ "$(readlink "$link")" = "$SRC/$name" ]; then
        rm "$link"
        removed=$((removed + 1))
      elif [ -e "$link" ]; then
        echo "skipped $name: not a symlink into this repository" >&2
      fi
    done
    echo "Removed $removed symlinks from $TARGET"
    ;;

  install)
    mkdir -p "$TARGET"
    linked=0
    for name in $(skills); do
      link="$TARGET/$name"
      if [ -L "$link" ]; then
        rm "$link"
      elif [ -e "$link" ]; then
        echo "refusing to replace $link: it's a real directory, not a symlink" >&2
        exit 1
      fi
      ln -s "$SRC/$name" "$link"
      linked=$((linked + 1))
    done
    echo "Linked $linked skills into $TARGET"
    echo "Start a new Claude Code session, then run /google-style to check."
    ;;
esac

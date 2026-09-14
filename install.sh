#!/usr/bin/env bash
# Enable and disable these skills in a Claude Code skills directory.
# Each enabled skill is a symlink, so the installed copy can't drift from
# this repository.
#
#   ./install.sh                     pick skills interactively
#   ./install.sh status              show what's enabled
#   ./install.sh enable NAME...      enable one or more skills
#   ./install.sh disable NAME...     disable one or more skills
#   ./install.sh set NAME...         enable exactly these and disable the rest
#   ./install.sh preset NAME         core | docs | review | all | none
#   ./install.sh --project DIR CMD   act on DIR/.claude/skills, not ~/.claude/skills
#   ./install.sh --target DIR CMD    act on DIR itself as the skills directory
#
# Presets:
#   core     google-style and google-style-review — the recommended start
#   docs     every writing skill
#   review   the two code review skills
#   all      everything
#   none     disable everything this script installed

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO/skills"
MANIFEST="$REPO/manifest.tsv"
TARGET="$HOME/.claude/skills"

[ -d "$SRC" ] || { echo "no skills directory at $SRC" >&2; exit 1; }
[ -f "$MANIFEST" ] || { echo "no manifest at $MANIFEST" >&2; exit 1; }

usage() { sed -n '2,20p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; }

# --- manifest ---------------------------------------------------------------

rows() { grep -v '^#' "$MANIFEST" | grep -v '^[[:space:]]*$'; }
all_names() { rows | cut -f1; }
field() { rows | awk -F'\t' -v n="$1" -v c="$2" '$1==n {print $c}'; }
group_of() { field "$1" 2; }
blurb_of() { field "$1" 4; }

preset_names() {
  rows | awk -F'\t' -v p="$1" '{
    n = split($3, a, ",")
    for (i = 1; i <= n; i++) if (a[i] == p) print $1
  }'
}

exists() { [ -d "$SRC/$1" ]; }

validate_names() {
  local n known
  known="$(echo " $(all_names) " | tr '\n' ' ' | tr -s ' ')"
  for n in "$@"; do
    case "$known" in
      *" $n "*) ;;
      *) echo "no such skill: $n" >&2
         echo "Run './install.sh status' for the names." >&2
         return 1 ;;
    esac
  done
}

# --- state ------------------------------------------------------------------

# ours | foreign | absent
state_of() {
  local link="$TARGET/$1"
  if [ -L "$link" ]; then
    case "$(readlink "$link")" in
      "$SRC/$1") echo ours ;;
      *)         echo foreign ;;
    esac
  elif [ -e "$link" ]; then
    echo foreign
  else
    echo absent
  fi
}

enabled_names() {
  local n
  for n in $(all_names); do
    [ "$(state_of "$n")" = ours ] && echo "$n"
  done
  return 0
}

# --- actions ----------------------------------------------------------------

# Collapse any whitespace to single spaces, so the " $name " membership tests
# below work whether the caller passed a list separated by spaces or newlines.
normalize() { echo " $* " | tr '\n\t' '  ' | tr -s ' '; }

contains() { case "$1" in *" $2 "*) return 0 ;; *) return 1 ;; esac; }

# The style skills read the word list that ships inside google-style, and the
# router table lives there too. Enabling one without it leaves dead references.
add_dependencies() {
  local wanted n
  wanted="$(normalize "$*")"
  contains "$wanted" google-style && { echo "$wanted"; return 0; }
  for n in $wanted; do
    case "$n" in
      google-style-*)
        echo "Also enabling google-style: the other writing skills read its word list." >&2
        echo "$(normalize "google-style $wanted")"
        return 0
        ;;
    esac
  done
  echo "$wanted"
}

enable_one() {
  local name="$1" link="$TARGET/$1"
  exists "$name" || { echo "no such skill: $name" >&2; return 1; }
  case "$(state_of "$name")" in
    ours)   return 0 ;;
    foreign)
      if [ -L "$link" ]; then
        rm "$link"
      else
        echo "refusing to replace $link: it's a real directory, not a symlink" >&2
        return 1
      fi
      ;;
  esac
  mkdir -p "$TARGET"
  ln -s "$SRC/$name" "$link"
}

disable_one() {
  local name="$1" link="$TARGET/$1"
  case "$(state_of "$name")" in
    ours)    rm "$link" ;;
    foreign) echo "skipped $name: not a symlink into this repository" >&2; return 1 ;;
  esac
  return 0
}

# Make the target directory match exactly the given list.
apply_selection() {
  local wanted n before after
  wanted="$(add_dependencies "$*")"
  before="$(normalize "$(enabled_names)")"

  for n in $(all_names); do
    if contains "$wanted" "$n"; then
      enable_one "$n" || true
    else
      disable_one "$n" || true
    fi
  done

  after="$(normalize "$(enabled_names)")"
  [ "$before" = "$after" ] && { echo "No change."; return 0; }
  status
  echo
  echo "Start a new Claude Code session for this to take effect."
}

status() {
  local n s count=0
  echo "Skills directory: $TARGET"
  echo
  printf '  %-2s %-26s %-8s %s\n' "" "SKILL" "GROUP" "STATE"
  for n in $(all_names); do
    s="$(state_of "$n")"
    case "$s" in
      ours)    s="enabled"; count=$((count + 1)) ;;
      absent)  s="-" ;;
      foreign) s="conflict" ;;
    esac
    printf '  %-2s %-26s %-8s %s\n' "" "$n" "$(group_of "$n")" "$s"
  done
  echo
  echo "$count of $(all_names | wc -l | tr -d ' ') enabled."
}

# The good picker is pick.ts, which needs bun and a terminal. This is the
# fallback for everyone else.
pick_plain() {
  local n i=0 names=() sel choice wanted=""
  for n in $(all_names); do names+=("$n"); done

  echo "Pick the skills you want. Each one adds its name and a one-line"
  echo "description to every session's context, so enable what you'll use."
  echo

  local group="" last=""
  for n in "${names[@]}"; do
    i=$((i + 1))
    group="$(group_of "$n")"
    [ "$group" != "$last" ] && { echo "$group"; last="$group"; }
    printf '  %2d) %-26s %s%s\n' "$i" "$n" \
      "$( [ "$(state_of "$n")" = ours ] && echo '[on]  ' || echo '      ' )" \
      "$(blurb_of "$n")"
  done

  echo
  echo "Enter numbers separated by spaces, a preset name (core, docs, review, all,"
  echo "none), or press Return to keep what's enabled now."
  printf '> '
  read -r sel || true

  case "$(echo "$sel" | tr -d '[:space:]')" in
    "")                       echo "Unchanged."; return 0 ;;
    core|docs|review|all)     apply_selection "$(preset_names "$(echo "$sel" | tr -d '[:space:]')")"; return 0 ;;
    none)                     apply_selection ""; return 0 ;;
  esac

  for choice in $sel; do
    case "$choice" in
      ''|*[!0-9]*) echo "not a number: $choice" >&2; return 2 ;;
    esac
    if [ "$choice" -lt 1 ] || [ "$choice" -gt "${#names[@]}" ]; then
      echo "out of range: $choice" >&2; return 2
    fi
    wanted="$wanted ${names[$((choice - 1))]}"
  done
  apply_selection "$wanted"
}

pick() {
  if [ -t 0 ] && [ -t 1 ] && command -v bun >/dev/null 2>&1 && [ -f "$REPO/pick.ts" ]; then
    bun run "$REPO/pick.ts" "$REPO" "$TARGET" && return 0
    echo "Falling back to the plain picker." >&2
  fi
  pick_plain
}

# --- arguments --------------------------------------------------------------

while [ $# -gt 0 ] && [ "${1#--}" != "$1" ]; do
  case "$1" in
    --project)
      [ $# -ge 2 ] || { echo "--project needs a directory" >&2; exit 2; }
      [ -d "$2" ] || { echo "no such directory: $2" >&2; exit 2; }
      TARGET="$(cd "$2" && pwd)/.claude/skills"
      shift 2
      ;;
    --target)
      [ $# -ge 2 ] || { echo "--target needs a directory" >&2; exit 2; }
      mkdir -p "$2"
      TARGET="$(cd "$2" && pwd)"
      shift 2
      ;;
    -h|--help) usage; exit 0 ;;
    *)         echo "unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

CMD="${1:-pick}"
[ $# -gt 0 ] && shift || true

case "$CMD" in
  pick)   pick ;;
  status|list) status ;;
  set)
    validate_names "$@" || exit 2
    apply_selection "$*"
    ;;
  enable)
    [ $# -gt 0 ] || { echo "enable needs at least one skill name" >&2; exit 2; }
    validate_names "$@" || exit 2
    apply_selection "$(enabled_names) $*"
    ;;
  disable)
    [ $# -gt 0 ] || { echo "disable needs at least one skill name" >&2; exit 2; }
    validate_names "$@" || exit 2
    dropping="$(normalize "$@")"
    keep=""
    for have in $(enabled_names); do
      contains "$dropping" "$have" || keep="$keep $have"
    done
    apply_selection "$keep"
    ;;
  preset)
    [ $# -eq 1 ] || { echo "preset needs one name: core, docs, review, all, none" >&2; exit 2; }
    case "$1" in
      none)                 apply_selection "" ;;
      core|docs|review|all) apply_selection "$(preset_names "$1")" ;;
      *) echo "unknown preset: $1" >&2; exit 2 ;;
    esac
    ;;
  uninstall) apply_selection "" ;;
  *) echo "unknown command: $CMD" >&2; usage >&2; exit 2 ;;
esac

#!/usr/bin/env bash
# Claude Code statusLine command, styled after the pi-footer extension (no icons)
# Left, in order:
#   1. model id / context window size / effort (bold)
#   2. context window usage % (yellow >= 70, red >= 90)
#   3. rate limit remaining %
#   4. cache hit % (last request)
# Right (dim): current directory name, git branch

input=$(cat)

# Colors (ANSI 256; accent matches the pi theme's purple)
ACCENT='\e[38;5;141m'
BOLD_ACCENT='\e[1;38;5;141m'
DIM='\e[38;5;244m'
WARN='\e[33m'
DANGER='\e[31m'
NC='\e[0m'

# Terminal width is unavailable on stdin; margin leaves room for Claude Code's own status line padding
MARGIN=4

# Extract every field in one jq call, one per line, in the order below
mapfile -t f < <(jq -r '
  (.model.id // .model.display_name // ""),
  (.context_window.context_window_size // ""),
  (.effort.level // ""),
  (.context_window.used_percentage // ""),
  (.rate_limits.five_hour.used_percentage // ""),
  ((.context_window.current_usage // {}) |
    (.cache_read_input_tokens // 0),
    ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))),
  (.workspace.current_dir // .cwd // "")
' <<<"$input")

model=${f[0]}
size=${f[1]}
effort=${f[2]}
used=${f[3]}
five=${f[4]}
cache_read=${f[5]:-0}
cache_total=${f[6]:-0}
cwd=${f[7]}

left=""
left_plain=""
# add_left COLOR TEXT: append a space-separated segment, skipping empty text
add_left() {
  local color=$1 text=$2
  [ -n "$text" ] || return 0
  if [ -n "$left" ]; then
    left+=" "
    left_plain+=" "
  fi
  left+="${color}${text}${NC}"
  left_plain+="$text"
}

# Context window size: 200000 -> 200k, 1000000 -> 1m
if [ -n "$size" ]; then
  if [ "$size" -ge 1000000 ]; then
    size="$((size / 1000000))m"
  else
    size="$((size / 1000))k"
  fi
fi

add_left "$BOLD_ACCENT" "$model"
add_left "$BOLD_ACCENT" "$size"
add_left "$BOLD_ACCENT" "$effort"

# Context window usage %, colored by threshold
if [ -n "$used" ]; then
  pct=$(printf '%.0f' "$used")
  color=$ACCENT
  [ "$pct" -ge 70 ] && color=$WARN
  [ "$pct" -ge 90 ] && color=$DANGER
  add_left "$color" "ctx:${pct}%"
fi

# Rate limit remaining %
if [ -n "$five" ]; then
  add_left "$ACCENT" "rl:$(awk -v f="$five" 'BEGIN{printf "%.0f", 100 - f}')%"
fi

# Cache hit %: cache reads / all input tokens of the last request
add_left "$ACCENT" "cache:$(awk -v r="$cache_read" -v t="$cache_total" 'BEGIN{printf "%.1f", (t > 0 ? 100 * r / t : 0)}')%"

# Right side: directory name and git branch
right=""
right_plain=""
if [ -n "$cwd" ]; then
  right_plain="${cwd##*/}"
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null || true)
  [ -n "$branch" ] && right_plain+=" $branch"
  right="${DIM}${right_plain}${NC}"
fi

# Flex separator: pad the gap so the right side hugs the edge when the width is known
cols=${COLUMNS:-$(stty size 2>/dev/null </dev/tty | awk '{print $2}' || true)}
gap=2
if [ -n "$cols" ]; then
  fill=$((cols - MARGIN - ${#left_plain} - ${#right_plain}))
  [ "$fill" -gt "$gap" ] && gap=$fill
fi

printf '%b%*s%b' "$left" "$gap" "" "$right"

#!/usr/bin/env bash
# Claude Code statusLine command
# Segments, in order:
#   1. current directory
#   2. model name / output style / effort
#   3. context window usage % / rate limit remaining %

input=$(cat)

# Colors (ANSI; dimmed variants render well against a dimmed terminal palette)
DIM_CYAN='\e[2;36m'
DIM_MAGENTA='\e[2;35m'
DIM_GREEN='\e[2;32m'
NC='\e[0m'

# Segment 1: current directory (home collapsed to ~)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir="${cwd/#$HOME/~}"

# Segment 2: model / output style / effort
model=$(echo "$input" | jq -r '.model.display_name // empty')
style=$(echo "$input" | jq -r '.output_style.name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')

seg2="$model"
[ -n "$style" ] && [ "$style" != "default" ] && seg2="${seg2}/${style}"
[ -n "$effort" ] && seg2="${seg2}/${effort}"

# Segment 3: context window usage % and rate limit remaining %
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

seg3=""
[ -n "$used" ] && seg3=$(printf 'ctx:%.0f%%' "$used")

if [ -n "$five" ]; then
  left=$(awk -v f="$five" 'BEGIN{printf "%.0f", 100 - f}')
  [ -n "$seg3" ] && seg3="${seg3} "
  seg3="${seg3}rl:${left}%"
fi

# Assemble output
out="$(printf "${DIM_CYAN}%s${NC}" "$dir")"
[ -n "$seg2" ] && out="${out}  $(printf "${DIM_MAGENTA}%s${NC}" "$seg2")"
[ -n "$seg3" ] && out="${out}  $(printf "${DIM_GREEN}%s${NC}" "$seg3")"

printf "%b" "$out"

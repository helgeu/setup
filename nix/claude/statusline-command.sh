#!/usr/bin/env bash
# Claude Code status line - powerline style, mirrors oh-my-posh rainbow theme
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
style=$(echo "$input" | jq -r '.output_style.name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five_hour_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
now_hms=$(date +%H:%M:%S)

display_cwd="${cwd/#$HOME/\~}"

# Git state
git_branch=""
git_dirty=0
git_ahead=0
git_behind=0
if gb=$(git -C "$cwd" -c gc.auto=0 symbolic-ref --short HEAD 2>/dev/null); then
  git_branch="$gb"
  git_status=$(git -C "$cwd" -c gc.auto=0 status --porcelain 2>/dev/null)
  [ -n "$git_status" ] && git_dirty=1
  git_ahead=$(git -C "$cwd" -c gc.auto=0 rev-list --count @{u}..HEAD 2>/dev/null || echo 0)
  git_behind=$(git -C "$cwd" -c gc.auto=0 rev-list --count HEAD..@{u} 2>/dev/null || echo 0)
fi

# --- Powerline glyphs (Nerd Font) ---
PL_ARROW=$'\ue0b0'        #
PL_DIAMOND_L=$'\ue0b2'    #
ICON_FOLDER=$'\uf07c'     #
ICON_BRANCH=$'\uf126'     #
ICON_MODEL=$'\uf2db'      #  (microchip)
ICON_CLOCK_5H=$'\uf252'   #  (hourglass)
ICON_CTX=$'\uf080'        #  (bar chart)
ICON_STYLE=$'\uf0e7'      #  (bolt)
ICON_TIME=$'\uf017'       #
ESC=$'\033'
RESET="${ESC}[0m"

seg_bg=()
seg_fg=()
seg_txt=()
add_seg() {
  seg_bg+=("$1")
  seg_fg+=("$2")
  seg_txt+=(" $3 ")
}

# Threshold colors for usage percentages (sets PCT_BG / PCT_FG)
pct_colors() {
  local p=$1
  if [ "$p" -lt 50 ] 2>/dev/null; then
    PCT_BG="78;154;6";    PCT_FG="0;0;0"          # green
  elif [ "$p" -lt 80 ] 2>/dev/null; then
    PCT_BG="196;160;0";   PCT_FG="0;0;0"          # yellow
  else
    PCT_BG="204;34;34";   PCT_FG="255;255;255"    # red
  fi
}

# 1. Path
add_seg "52;101;164" "230;230;230" "${ICON_FOLDER} ${display_cwd}"

# 2. Git (if in a repo)
if [ -n "$git_branch" ]; then
  if [ "$git_ahead" -gt 0 ] && [ "$git_behind" -gt 0 ]; then
    gbg="242;109;80";   gfg="0;0;0"              # diverged → orange
  elif [ "$git_ahead" -gt 0 ] || [ "$git_behind" -gt 0 ]; then
    gbg="137;209;220";  gfg="0;0;0"              # out of sync → cyan
  elif [ "$git_dirty" -eq 1 ]; then
    gbg="196;160;0";    gfg="0;0;0"              # dirty → yellow
  else
    gbg="78;154;6";     gfg="0;0;0"              # clean → green
  fi
  gtxt="${ICON_BRANCH} ${git_branch}"
  [ "$git_dirty" -eq 1 ] && gtxt="$gtxt *"
  [ "$git_ahead" -gt 0 ] && gtxt="$gtxt +$git_ahead"
  [ "$git_behind" -gt 0 ] && gtxt="$gtxt -$git_behind"
  add_seg "$gbg" "$gfg" "$gtxt"
fi

# 3. Model (Claude orange)
add_seg "217;119;87" "255;255;255" "${ICON_MODEL} ${model}"

# 4. 5h session usage (Pro/Max; absent for API key and first response)
if [ -n "$five_hour_pct" ]; then
  p5=${five_hour_pct%.*}
  pct_colors "$p5"
  pct_display=$(printf '%.0f' "$five_hour_pct")
  txt="${ICON_CLOCK_5H} ${pct_display}%"
  if [ -n "$five_hour_resets" ]; then
    diff=$((five_hour_resets - $(date +%s)))
    [ "$diff" -lt 0 ] && diff=0
    h=$((diff / 3600))
    m=$(((diff % 3600) / 60))
    if [ "$h" -gt 0 ]; then
      tleft=$(printf '%dh %02dm' "$h" "$m")
    else
      tleft="${m}m"
    fi
    txt="$txt · $tleft"
  fi
  add_seg "$PCT_BG" "$PCT_FG" "$txt"
fi

# 5. Context window usage
if [ -n "$used" ]; then
  ui=${used%.*}
  pct_colors "$ui"
  add_seg "$PCT_BG" "$PCT_FG" "${ICON_CTX} ${used}%"
fi

# 6. Output style (skip default/empty)
if [ -n "$style" ] && [ "$style" != "default" ]; then
  add_seg "104;159;99" "255;255;255" "${ICON_STYLE} ${style}"
fi

# 7. Time (light gray, trailing)
add_seg "211;215;207" "0;0;0" "${ICON_TIME} ${now_hms}"

# --- Render ---
prev_bg=""
for i in "${!seg_bg[@]}"; do
  bg="${seg_bg[$i]}"
  fg="${seg_fg[$i]}"
  txt="${seg_txt[$i]}"
  if [ -z "$prev_bg" ]; then
    printf "${ESC}[38;2;%sm%s" "$bg" "$PL_DIAMOND_L"
  else
    printf "${ESC}[48;2;%sm${ESC}[38;2;%sm%s" "$bg" "$prev_bg" "$PL_ARROW"
  fi
  printf "${ESC}[48;2;%sm${ESC}[38;2;%sm%s" "$bg" "$fg" "$txt"
  prev_bg="$bg"
done
if [ -n "$prev_bg" ]; then
  printf "${ESC}[49m${ESC}[38;2;%sm%s%s" "$prev_bg" "$PL_ARROW" "$RESET"
fi

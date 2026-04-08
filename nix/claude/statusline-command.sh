#!/usr/bin/env bash
# Claude Code status line - mirrors oh-my-posh theme segments
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
style=$(echo "$input" | jq -r '.output_style.name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
time=$(date +%H:%M:%S)

# Shorten home directory to ~
home="$HOME"
display_cwd="${cwd/#$home/\~}"

# Git branch and status (skip optional locks)
git_info=""
if git_branch=$(git -C "$cwd" -c gc.auto=0 symbolic-ref --short HEAD 2>/dev/null); then
  git_info=" $git_branch"
  # Check for working/staging changes
  git_status=$(git -C "$cwd" -c gc.auto=0 status --porcelain 2>/dev/null)
  if [ -n "$git_status" ]; then
    git_info="$git_info *"
  fi
  # Check ahead/behind
  ahead=$(git -C "$cwd" -c gc.auto=0 rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
  behind=$(git -C "$cwd" -c gc.auto=0 rev-list --count HEAD..@{u} 2>/dev/null || echo "0")
  [ "$ahead" -gt 0 ] 2>/dev/null && git_info="$git_info +${ahead}"
  [ "$behind" -gt 0 ] 2>/dev/null && git_info="$git_info -${behind}"
fi

# Context usage
context_info=""
if [ -n "$used" ]; then
  context_info=" | ctx: ${used}%"
fi

printf "%s%s | %s | %s%s | %s" \
  "$display_cwd" \
  "$git_info" \
  "$model" \
  "$style" \
  "$context_info" \
  "$time"

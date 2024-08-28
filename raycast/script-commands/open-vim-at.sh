#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title open-vim-at
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "absolute filepath" }
# @raycast.argument2 { "type": "text", "placeholder": "line number" }
# @raycast.packageName git-delta

# Documentation:
# @raycast.description Opens vim in new tmux pane with provided file and line number.
# @raycast.author bnew10 
# @raycast.authorURL https://github.com/bnew10

FILE="$1"
LINE_NUM="$2"

# returns the current active pane (e.g., main:2.1)
get-pane () {
  tmux display-message -p '#{session_name}:#{window_index}.#{pane_index}'
}
# returns the current active window (e.g., main:2)
get-window () {
  tmux display-message -p '#{session_name}:#{window_index}'
}

WINDOW="$(get-window)"
VIM_PANE_INDEX="$(tmux list-panes -t "$WINDOW" -F '#{pane_index} #{pane_current_command}' | awk '$2 == "vim" { print $1; exit}')"

# if there's already a pane in the current window running vim
if [ -n "$VIM_PANE_INDEX" ]; then
  TARGET="$WINDOW.$VIM_PANE_INDEX"
  # open specified file and line number in pre-existing vim instance
  tmux send-keys -t "$TARGET" ":e +$LINE_NUM $FILE" C-m
  # Make the vim pane the active pane
  tmux select-pane -t "$TARGET"
else
  # Split the specified window and focus on the new pane running vim
  tmux split-window -t "$(get-pane)" "vim +$LINE_NUM $FILE"
fi

osascript -e 'tell application "iTerm" to activate'


#!/usr/bin/env zsh

# aliases
alias lal="ls -Alh"
alias c="clear && cd"
path () {
  echo $PATH | sed 's/:/\n/g'
}

# jar debug string (jds)
DEBUG_STR="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
alias jds="echo $DEBUG_STR && command -v pbcopy &> /dev/null && echo -n $DEBUG_STR | pbcopy"

# homebrew
alias bud="brew update && echo '\n' && brew outdated --greedy"
alias bug="brew upgrade --greedy"

# github copilot cli
alias ghcs="gh copilot suggest"
alias ghce="gh copilot explain"

# tmux
alias tcs='open https://tmuxcheatsheet.com'

# fzf
FZF_DEFAULTS=(--multi --cycle)
alias fze="fzf ${FZF_DEFAULTS[*]} --bind 'enter:become(vim {+})'"

# git
gs () {
  GST_OUT=$(git -c color.status=always status -s | fzf ${FZF_DEFAULTS[@]} --ansi | awk '{ print $2 }') \
    && echo $GST_OUT \
    && echo $GST_OUT | tr '\n' ' ' | pbcopy
}
command -v gsh &> /dev/null && unalias gsh
gsh () {
  TMP=$(git show --first-parent --name-only --oneline $1 | awk 'NR>1') && echo "$TMP" && echo "$TMP" | tr '\n' ' ' | pbcopy
}
alias gst='git-st'
alias gds="git -c color.status=always status -s \$(git diff --name-only) | fzf ${FZF_DEFAULTS[*]} --ansi --bind 'enter:execute(git diff {+2})'"
alias gdss="git -c color.status=always status -s \$(git diff --name-only --cached) | fzf ${FZF_DEFAULTS[*]} --ansi --bind 'enter:execute(git diff --staged {+2})'"
alias jars="git status -s | awk -F '/' '{ print \$2 }' | uniq"

# raycast
alias confetti="open -g raycast://confetti"

# docker
dsh () {
  docker exec -it $1 /bin/bash
}
export COMPOSE_DIR=(~/scripts-tools/compose.yml)
dcupdate () {
  docker compose -f ${COMPOSE_DIR[@]} pull $1 && docker compose -f ${COMPOSE_DIR[@]} up -d $1
}
alias dc='docker compose'

# ultx
is-active () {
  ultx is-active | awk '{if ($0 ~ /active/) {print "\033[0;32m" $0 "\033[0m"} else if ($0 ~ /failed/) {print "\033[0;31m" $0 "\033[0m"} else {print $0}}'
}


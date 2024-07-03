#!/usr/bin/env bash

FZF_DEFAULTS=(--multi --cycle)

# aliases
alias lal="ls -Alh"
alias c="clear && cd"
alias path="echo $PATH | sed 's/:/\n/g'"

# jar debug string (jds)
alias jds="echo '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005'"

# homebrew
alias bud="brew update && echo '\n' && brew outdated --greedy"
alias bug="brew upgrade --greedy"

# vagrant
alias vgs="ssh nuc vagrant global-status"
alias vu="ssh nuc vagrant up"
alias vh="ssh nuc vagrant halt"
alias vr="ssh nuc vagrant reload"

# github copilot cli
alias ghcs="gh copilot suggest"
alias ghce="gh copilot explain"

# xplr
alias xcd='cd "$(xplr --print-pwd-as-result)"'

# intellij
alias ijopen='open -a IntelliJ\ IDEA'

# tmux
alias tcs='open https://tmuxcheatsheet.com'

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

# fzf
alias fze="fzf ${FZF_DEFAULTS[*]} --bind 'enter:become(vim {+})'"


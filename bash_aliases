#!/usr/bin/env bash

# aliases
alias lal="ls -Alh"
alias c="clear && cd"
alias path="echo $PATH | sed 's/:/\n/g'"

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
alias gst='git-st'
gs () {
  GST_OUT=$(git -c color.status=always status -s | fzf --ansi --multi | awk '{ print $2 }') \
    && echo $GST_OUT \
    && echo $GST_OUT | tr '\n' ' ' | pbcopy
}
alias gds="git -c color.status=always status -s \$(git diff --name-only) | fzf --ansi --multi --bind 'enter:execute(git diff {+2})'"
alias gdss="git -c color.status=always status -s \$(git diff --name-only --cached) | fzf --ansi --multi --bind 'enter:execute(git diff --staged {+2})'"
alias jars="git status -s | awk '{ print \$2 }' | tree --fromfile -L 2"

# fzf
alias fze="fzf --multi --bind 'enter:become(vim {+})'"


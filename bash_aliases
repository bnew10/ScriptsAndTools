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

# env vars
export JAVA_HOME="/lib/jvm/java-1.8.0-openjdk-1.8.0.382.b05-2.el8.x86_64"
export ACCELERATE_INSTALL_DIRECTORY="/tmp/installer"

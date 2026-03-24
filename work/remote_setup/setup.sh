#!/usr/bin/env bash

set -e

# if no argument is given, give usage info
if [ $# -eq 0 ]; then
  echo "Usage: $0 <ssh-destination>"
  echo "Example: $0 user@hostname"
  exit 1
fi

yellow="\033[33m"
cyan="\033[36m"
red="\033[31m"
green="\033[32m"
nc="\033[0m"

user="$1"
shift

# map user to home dir
declare -A home_dir_map=(
  ["root"]="/root"
  ["opsadmin"]="/home/opsadmin"
)
home="${home_dir_map[$user]}"

# local path to remote path mapping
declare -A src_to_dst=(
  ["./cleanup+installation"]="/var/local/tmp"
  ["./aliases"]="$home/.aliases"
  ["./inputrc"]="$home/.inputrc"
  ["./tmux.conf"]="$home/.tmux.conf"
  ["./vimrc"]="$home/.vimrc"
  ["./ntfy"]="/usr/local/bin/ntfy"
  ["./tmux-3.6a-linux-x86_64.tar.gz"]="/tmp/tmux.tar.gz"
)

for remote in "$@"; do

  echo -e "$green$remote setup:$nc"

  # scp each local file to their remote dst path
  for src in "${!src_to_dst[@]}"; do
    dst="${src_to_dst[$src]}"
    echo -e "=== Copying $yellow$src$nc to $cyan$remote:$dst$nc"
    scp -rO "$src" "$remote:$dst"
  done

  src_aliases="source\ $home/.aliases"
  config_bin="export\ PATH=\\\"/usr/share/vcinity/configuration/bin:\\\$PATH\\\""
  tmux_esc="export\ TMUX_ESC=1"
  lines=("$src_aliases" "$config_bin" "$tmux_esc")
  bashrc="$home/.bashrc"
  symlink="$home/cleanup+installation"
  realpath="/var/local/tmp/cleanup+installation"
  port=4444
  proxy="http://localhost:${port}"
  cmds=$(
    cat <<-CMD
    # if remote's .bashrc doesn't contain config lines, append them
    for line in ${lines[@]}; do
      if ! grep "\$line" "$bashrc" >/dev/null; then
        echo -e "=== Appending \"$yellow\$line$nc\" to $cyan$bashrc$nc"
        echo -e "\n\$line" >>"$bashrc"
      fi
    done

    # if home directory symlink doesn't exist, create it
    if [ ! -h "$symlink" ]; then
      echo -e "=== Creating symlink to $yellow$realpath$nc in home directory"
      ln -s "$realpath" "$symlink"
    fi
    
    # vim setup
    echo "=== Installing vim plugins"
    export http_proxy="${proxy}"
    export https_proxy="${proxy}"
    vim "+PlugInstall --sync" +qa

    # tmux setup
    echo "=== Upgrading tmux"

    tar -xzvf /tmp/tmux.tar.gz -C /usr/bin
CMD
  )

  tinyproxy 2>&1 | sed 's/^/[tinyproxy] /'
  ssh -R $port:localhost:8888 -t "$remote" "$cmds"
  kill -9 $(pgrep tinyproxy)
  echo "[tinyproxy] Shutdown successful"

  ssh -R 12345:localhost:22 "$remote" 'ssh-keyscan -H -p 12345 localhost >>"$HOME/.ssh/known_hosts"'

  remote_pub="$(ssh "$remote" 'cat $HOME/.ssh/*.pub')"
  if ! grep "$remote_pub" "$HOME/.ssh/authorized_keys"; then
    echo "$remote_pub" >>"$HOME/.ssh/authorized_keys"
    echo "Appended remote host's .pub keys to authorized_keys"
  fi
done
